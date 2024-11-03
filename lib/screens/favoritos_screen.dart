import 'package:app_movies_api/models/triler_model.dart';
import 'package:app_movies_api/services/movie_api.dart';
import 'package:flutter/material.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  MovieApi movieApi = MovieApi();
  Map<String, dynamic>? favorito;
  String id_acount = '21551989';

  @override
  void initState() {
    super.initState();
    recuperarFavoritos();
  }

  Future<void> recuperarFavoritos() async {
    final result = await movieApi.getFavoriteMovies(id_acount);
    setState(() {
      favorito = result;
    });
    print('Le da los valores a favorito=$favorito');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAVORITOS'),
      ),
      body: favorito == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Muestra un indicador de carga mientras se espera la data
          : ListView.builder(
              itemCount: favorito?['results']?.length ?? 0,
              itemBuilder: (context, index) {
                final movie = favorito?['results'][index];
                return ListTile(
                  title: Text(movie?['title'] ?? 'Sin título'),
                  subtitle: Text(movie?['overview'] ?? 'Sin descripción'),
                  trailing: IconButton(
                      onPressed: () async {
                        try {
                          await movieApi.deleteToFavorites(
                              '21551989', movie?['id'], false);
                        } catch (e) {
                          print('errro $e');
                        }

                        setState(() {
                          
                        });
                      },
                      icon: Icon(Icons.delete_forever)),
                );
              },
            ),
    );
  }
}
