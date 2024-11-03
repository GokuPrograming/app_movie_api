import 'package:app_movies_api/models/Movie_model.dart';
import 'package:app_movies_api/services/movie_api.dart';
import 'package:flutter/material.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});
  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  MovieApi? movieApi;
  @override
  void initState() {
    super.initState();
    movieApi = MovieApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los estrenos'),
      ),
      body: FutureBuilder(
          future: movieApi!.getAllMovies(),
          builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  ///se trae con el snapshot todos y cada uno de los elmentos
                  return CardPopular(snapshot.data![index]);
                  //     Text(snapshot.data![index].title);
                },
              );
            } else {
              if (snapshot.hasError) {
                print('el error es este');
                print(snapshot.error);
                return const Center(
                  child: Text('Something was wrong :()'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget CardPopular(MovieModel movie) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detalle', arguments: movie),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Hero(
         tag: 'hero_${movie.id}',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}')),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Opacity(
                  opacity: .7,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      movie.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    height: 50,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
