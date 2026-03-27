import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/tmdb_movie.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<TmdbMovie> films = [];
  String recherche = '';
  String? erreur;

  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  Future<void> fetchFilms() async {
    try {
      final uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=57e07701d99404b61812b9bcb9572d49',
      );
      final response = await http.get(uri);
      final data = jsonDecode(response.body);
      setState(() => films = (data['results'] as List).map((e) => TmdbMovie.fromJson(e)).toList());
    } catch (e) {
      setState(() => erreur = 'Erreur de chargement');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (erreur != null) return Center(child: Text(erreur!));
    if (films.isEmpty) return const Center(child: CircularProgressIndicator());

    final filmsFiltres = films.where((f) => f.title.toLowerCase().contains(recherche.toLowerCase())).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Rechercher...', border: OutlineInputBorder()),
            onChanged: (valeur) => setState(() => recherche = valeur),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: filmsFiltres.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final film = filmsFiltres[index];
              return ListTile(
                title: Text(film.title),
                subtitle: Text('${film.year} • ⭐ ${film.rating}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
