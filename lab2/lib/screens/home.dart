import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab2/models/joke_type.dart';
import '../services/api_service.dart';
import '../widgets/types_list.dart';
import 'joke_of_the_day.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<JokeType> types = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    ApiService.getCategories().then((response) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        types = data.map<JokeType>((type) => JokeType(type: type)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Jokes App - 213132",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 9,
                padding: const EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/joke-of-the-day');
              },
              child: const Text(
                "Joke of the Day",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10), // Add spacing above the title
            child: Text(
              "Joke Types:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: TypesList(types: types),
          ),
        ],
      ),
    );
  }
}
