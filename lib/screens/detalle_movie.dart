import 'package:app_movies_api/models/Movie_model.dart';
import 'package:app_movies_api/services/movie_api.dart';
import 'package:app_movies_api/widgets/Credits.dart';
import 'package:app_movies_api/widgets/lista_actores_widget.dart';
import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:horizontal_list/horizontal_list.dart';

class DetalleMovie extends StatefulWidget {
  const DetalleMovie({super.key});

  @override
  State<DetalleMovie> createState() => _DetalleMovieState();
}

class _DetalleMovieState extends State<DetalleMovie> {

  int? id_movie;

  @override


  @override
  Widget build(BuildContext context) {
    @override

 
        final movieData =
        ModalRoute.of(context)?.settings.arguments as MovieModel;

    // setState(() {
    //   id_movie = movieData.id;
    //   ObtenerActores();
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie: ${movieData.originalTitle}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Hero(
          tag: 'hero_${movieData.id}',
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(color: Colors.grey[850]), // Fondo oscuro
                child: Stack(
                  children: [
                    //imagen de fondo
                    Image.network(
                      'https://image.tmdb.org/t/p/w500/${movieData.posterPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ).blurred(
                      colorOpacity: 0.5,
                      borderRadius: BorderRadius.circular(15),
                      blur: 10,
                    ),

                    // Contenedor con la imagen y el rating
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.06,
                      left: MediaQuery.of(context).size.width * 0.05,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.black54,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movieData.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    //icono de favorito
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.06,
                      left: MediaQuery.of(context).size.width * 0.3,
                      child: IconButton(
                        onPressed: () {
                          //obtener id
                          print('El id de la pelicula=${movieData.id}');
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: const Color.fromARGB(255, 226, 114, 106),
                        ),
                      ),
                    ),
                    // Información del rating
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.025,
                      left: MediaQuery.of(context).size.width * 0.015,
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  10), // Espacio entre el texto y el progress indicator
                          Transform.rotate(
                            angle: 6,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .1,
                              height: MediaQuery.of(context).size.height * .05,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: movieData.voteAverage / 10,
                                    strokeWidth: 1,
                                    color: Colors.amber,
                                    backgroundColor: const Color.fromARGB(
                                        255, 248, 248, 248),
                                  ),
                                  Text(
                                    '${movieData.voteAverage.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Titulo
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.06,
                      left: MediaQuery.of(context).size.width * 0.48,
                      child: Container(
                        // alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * .50,
                        height: MediaQuery.of(context).size.height * .33,
                        // decoration: BoxDecoration(color: Colors.black12),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${movieData.title}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text(
                              '${movieData.id}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '${movieData.releaseDate}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                '${movieData.overview}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //subtitulo

                    //duracion
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height * 0.1,
                    //   left: MediaQuery.of(context).size.width * 0.5,
                    //   child: Container(
                    //     // alignment: Alignment.centerLeft,
                    //     width: MediaQuery.of(context).size.width * .4,
                    //     height: MediaQuery.of(context).size.height * .2,
                    //     decoration: BoxDecoration(color: Colors.black12),

                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Text('Estreno: ${movieData.releaseDate}'),
                    //         Text('Lenguaje: ${movieData.originalLanguage}'),
                    //         Text('Lenguaje: ${movieData.title}'),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),

              ///lista de actores en la pelicula
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('REPARTO'),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListaActoresWidget(movieData.id))
            ],
          ),
        ),
      ),
      //triller
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     width: MediaQuery.of(context).size.width,
      //     height: 250,
      //     decoration: BoxDecoration(color: Colors.amber),
      //   ),
      // ),

      // Container(
      //   width: 100,
      //   height: 100,
      //   child: Credits(),
      // ),
    );
  }
}
