import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> movies = [
    Movie('Inception', 8.8, 'https://image.tmdb.org/t/p/w200/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg', 'Un voleur infiltre les rêves.', '2010'),
    Movie('Interstellar', 8.6, 'https://image.tmdb.org/t/p/w200/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', 'Voyage à travers un trou de ver.', '2014'),
    Movie('The Dark Knight', 9.0, 'https://image.tmdb.org/t/p/w200/qJ2tW6WMUDux911r6m7haRef0WH.jpg', 'Batman contre le Joker.', '2008'),
    Movie('Avengers: Endgame', 8.4, 'https://image.tmdb.org/t/p/w200/or06FN3Dka5tukK1e9sl16pB3iy.jpg', 'Les Avengers affrontent Thanos une dernière fois.', '2019'),
    Movie('The Matrix', 8.7, 'https://image.tmdb.org/t/p/w200/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg', 'Un hacker découvre la vérité sur son monde.', '1999'),
    Movie('Parasite', 8.5, 'https://image.tmdb.org/t/p/w200/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', 'Deux familles aux destins entrelacés.', '2019'),
    Movie('Pulp Fiction', 8.9, 'https://image.tmdb.org/t/p/w200/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg', 'Histoires croisées dans le milieu criminel.', '1994'),
    Movie('Forrest Gump', 8.8, 'https://image.tmdb.org/t/p/w200/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg', 'La vie extraordinaire d\'un homme ordinaire.', '1994'),
    Movie('The Lion King', 8.5, 'https://image.tmdb.org/t/p/w200/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg', 'Simba doit reprendre sa place de roi.', '1994'),
  ];

  Movie? selectedMovie;

  void selectMovie(Movie movie) {
    selectedMovie = movie;
    notifyListeners();
  }

  void updateMovie(Movie updated) {
    final index = movies.indexOf(selectedMovie!);
    movies[index] = updated;
    selectedMovie = updated;
    notifyListeners();
  }
}
