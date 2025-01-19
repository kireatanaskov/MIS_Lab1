import 'package:flutter/material.dart';
import 'package:lab3/models/favorite_jokes.dart';
import 'package:lab3/models/joke.dart';
import 'package:lab3/services/api_service.dart';

class Jokes extends StatefulWidget {
  final String type;

  const Jokes({required this.type, super.key});

  @override
  State<StatefulWidget> createState() => _JokesState();
}

class _JokesState extends State<Jokes> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    fetchJokes();
  }

  void fetchJokes() async {
    final fetchedJokes = await ApiService.getJokesByType(widget.type);
    setState(() {
      jokes = fetchedJokes;
    });
  }

  void toggleFavorite(Joke joke) {
    setState(() {
      if (FavoriteJokes.isFavorite(joke)) {
        FavoriteJokes.removeFavorite(joke);
      } else {
        FavoriteJokes.addFavorite(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "JOKES - ${widget.type.toUpperCase()}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: jokes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFavorite = FavoriteJokes.isFavorite(joke);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        toggleFavorite(joke);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
