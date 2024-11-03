import 'dart:convert';

import 'package:app_movies_api/models/Movie_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  final dio = Dio();
  Future<List<MovieModel>> getAllMovies() async {
    String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=052ff25c66e82692ddc28fcea03247e2&languaje=es-MX&page=1';
    //5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1
    final response = await dio.get(url);
    //se parcio la lista
    final res = response.data['results'] as List;
// Se lo pasamos a una lista
    return res.map((popular) => MovieModel.fromMap(popular)).toList();
  }

  Future<Map<String, dynamic>> fetchCredits(int idMovie) async {
    final apiKey = '052ff25c66e82692ddc28fcea03247e2';
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$idMovie/credits?api_key=$apiKey&language=es-MX');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }
}
