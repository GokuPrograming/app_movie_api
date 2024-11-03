import 'package:app_movies_api/models/Movie_model.dart';
import 'package:app_movies_api/services/movie_api.dart';
import 'package:app_movies_api/widgets/lista_actores_widget.dart';
import 'package:app_movies_api/widgets/triler_widget.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class DetalleMovie extends StatefulWidget {
  const DetalleMovie({super.key});

  @override
  State<DetalleMovie> createState() => _DetalleMovieState();
}

class _DetalleMovieState extends State<DetalleMovie>
    with SingleTickerProviderStateMixin {
  MovieApi movieApi = MovieApi();
  //animacion de rebote
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  ///fin animacion rebote
  ///
  int? id_movie;
  bool _isVisible = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _startDelay();

    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');

    ///animacion de rebote
    _controller = AnimationController(
      duration:
          Duration(milliseconds: 600), // Duración de la animación de rebote
      vsync: this, // 'this' se refiere al SingleTickerProviderStateMixin actual
    );

    // Definimos la animación de escala con un efecto de rebote
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve:
          Curves.elasticOut, // Usa Curves.elasticOut para el efecto de rebote
    );

    // Iniciar la animación al construir el widget
    _controller.forward();
    //fin de animacion de rebote
  }

  void _startDelay() async {
    await Future.delayed(Duration(milliseconds: 10)); // Espera de 1 segundo
    setState(() {
      _isVisible = true; // Cambia el estado para mostrar el widget
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    final movieData = ModalRoute.of(context)?.settings.arguments as MovieModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie: ${movieData.originalTitle}'),
        centerTitle: true,
      ),
      body: _isVisible
          ? SingleChildScrollView(
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
                                child: _isVisible
                                    ? Image.network(
                                        'https://image.tmdb.org/t/p/w500/${movieData.posterPath}',
                                        fit: BoxFit.cover,
                                      )
                                    : CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          //icono de favorito
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.06,
                            left: MediaQuery.of(context).size.width * 0.3,
                            child: IconButton(
                              onPressed: () async {
                                MovieApi movieApi = MovieApi();
                                movieApi.addToFavorites(
                                    '21551989', movieData.id, true);
                                print('El id de la pelicula=${movieData.id}');
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: const Color.fromARGB(255, 37, 37, 37),
                              ),
                            ),
                          ),
                          // Información del rating
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.025,
                            left: MediaQuery.of(context).size.width * 0.015,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          10), // Espacio entre el texto y el progress indicator
                                  Transform.rotate(
                                    angle: 6,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .05,
                                      decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(1000)),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: movieData.voteAverage / 10,
                                            strokeWidth: 1,
                                            color: Colors.amber,
                                            backgroundColor:
                                                const Color.fromARGB(
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
                      child: ListaActoresWidget(movieData.id),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Triler'),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TrilerWidget(
                          movieData.id,
                        ))
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
