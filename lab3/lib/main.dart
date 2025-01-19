import 'package:flutter/material.dart';
import 'package:lab3/screens/favorites.dart';
import 'package:lab3/services/firebase_api.dart';
import 'package:lab3/screens/joke_of_the_day.dart';
import 'package:lab3/screens/jokes.dart';
import 'screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/jokes': (context) => Jokes(type: ModalRoute.of(context)!.settings.arguments as String),
        '/joke-of-the-day': (context) => const JokeOfTheDay(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
