import 'package:app_movies_api/routes/routes.dart';
import 'package:app_movies_api/screens/movies_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const MoviesScreen(),
        routes: AppRoutes.routes,
      ),
    );
  }
}
