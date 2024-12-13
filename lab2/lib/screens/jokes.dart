import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/models/joke.dart';
import 'package:lab2/services/api_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
            "JOKES - ${widget.type.toUpperCase()}",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: jokes.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                ),
              );
            },
        )
    );
  }
}