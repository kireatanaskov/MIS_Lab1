import 'package:flutter/material.dart';
import 'package:lab2/screens/joke_of_the_day.dart';
import 'package:lab2/screens/jokes.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/jokes': (context) => Jokes(type: ModalRoute.of(context)!.settings.arguments as String),
        '/joke-of-the-day': (context) => const JokeOfTheDay(),
      },
    );
  }
}