import 'package:flutter/material.dart';

import '../models/joke.dart';
import '../services/api_service.dart';

class JokeOfTheDay extends StatefulWidget {
  const JokeOfTheDay({super.key});

  @override
  State<StatefulWidget> createState() => _JokeOfTheDayState();
}

class _JokeOfTheDayState extends State<JokeOfTheDay> {
  Joke? joke;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJokeOfTheDay();
  }

  void fetchJokeOfTheDay() async {
    final fetchedJoke = await ApiService.getJokeOfTheDay();
    setState(() {
      joke = fetchedJoke;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
            "JOKE OF THE DAY",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  joke!.setup,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  joke!.punchline,
                  style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}