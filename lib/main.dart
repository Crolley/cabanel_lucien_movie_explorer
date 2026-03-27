import 'package:cabanel_lucien_movie_explorer/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'posts_page.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<MovieProvider>(context, listen: false).selectMovie(movie);
        Navigator.pushNamed(context, '/details');
      },
      child: Row(
        children: [
          Image.network(movie.imageUrl, width: 80),
          Text(' ${movie.title} (${movie.year}) ⭐ ${movie.rating}'),
        ],
      ),
    );
  }
}

void main() {
  runApp(ChangeNotifierProvider(create : (_) => MovieProvider(),
  child: const MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Explorer',
      //Route Statique
      routes: {
        "/": (context) => HomePage(),
      },
      //route dynamique
      onGenerateRoute:(settings) {
        if (settings.name == '/details'){
          return MaterialPageRoute(builder: (context) => const DetailsScreen(),);
        }
        return null;
      },
    );  
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieProvider>(context).selectedMovie!;

    String title    = movie.title;
    String rating   = movie.rating.toString();
    String overview = movie.overview;
    String year     = movie.year;

    return Scaffold(
      appBar: AppBar(title: Text("Modifier le film"), backgroundColor: Colors.redAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(initialValue: title, decoration: InputDecoration(labelText: 'Titre'), onSaved: (validation) => title = validation!),
              TextFormField(initialValue: rating, decoration: InputDecoration(labelText: 'Note'), onSaved: (validation) => rating = validation!, keyboardType: TextInputType.number),
              TextFormField(initialValue: overview, decoration: InputDecoration(labelText: 'Description'), onSaved: (validation) => overview = validation!),
              TextFormField(initialValue: year, decoration: InputDecoration(labelText: 'Année'), onSaved: (validation) => year = validation!),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Sauvegarder'),
                onPressed: () {
                  _formKey.currentState!.save();
                  final updated = Movie(title, double.parse(rating), movie.imageUrl, overview, year);
                  Provider.of<MovieProvider>(context, listen: false).updateMovie(updated);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomePage> {
  int _currentIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<MovieProvider>(context).movies;
    final pages = [
      ListView(
        children: [
          for (var movie in movies)
            MovieCard(movie: movie)

        ],
      ),
      const PostsPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Movie Explorer"), backgroundColor: Colors.red),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Recherche'),
        ],
      ),
    );
  }
}

