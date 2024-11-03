import 'package:app_movies_api/screens/detalle_movie.dart';
import 'package:app_movies_api/screens/movies_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const principal = '/movies';
  static const detalle_movie = '/detalle';

  static final routes = <String, WidgetBuilder>{
    //recibe una cadena , y un witget
    principal: (context) => const MoviesScreen(),
    detalle_movie: (context) => const DetalleMovie(),
  };
}
