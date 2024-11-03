import 'package:app_movies_api/services/movie_api.dart';
import 'package:flutter/material.dart';

class ListaActoresWidget extends StatefulWidget {
  final int id;
  const ListaActoresWidget(this.id, {super.key});

  @override
  State<ListaActoresWidget> createState() => _ListaActoresWidgetState();
}

class _ListaActoresWidgetState extends State<ListaActoresWidget> {
  MovieApi movieApi = MovieApi();
  Map<String, dynamic>? actores;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ObtenerActores(widget.id);
  }

  Future<void> ObtenerActores(int id) async {
    try {
      var result = await movieApi.fetchCredits(id);
      if (mounted) {
        setState(() {
          actores = result; // Guarda los actores obtenidos
          isLoading = false; // Cambia el estado a no cargando
        });
      }
    } catch (e) {
      print("Error obteniendo actores: $e");
      if (mounted) {
        setState(() {
          isLoading = false; // Cambia el estado a no cargando en caso de error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator()); // Muestra un indicador de carga
    }

    if (actores == null || actores!['cast'].isEmpty) {
      return Center(
          child: Text(
              "No se encontraron actores.")); // Mensaje si no se encontraron actores
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
        itemCount: actores!['cast'].length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actores!['cast'][index];
          return Container(
            width: 80, // Ancho del contenedor
            height: 80, // Altura del contenedor para que sea circular
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  // color: Colors.red,
                ),
                child: actor['profile_path'] == null
                    ? Text('no hay foto')
                    : ClipOval(
                        // Asegura que la imagen sea circular
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${actor['profile_path']}',
                          fit: BoxFit.cover, // Cambiar a BoxFit.cover
                          width: 80, // Añadir ancho
                          height: 80, // Añadir altura
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
