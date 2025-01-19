import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiService {
  static Future<http.Response> getCategories() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    final List<dynamic> data = json.decode(response.body);

    return data.map<Joke>((joke) => Joke.fromJson(joke)).toList();
  }

  static Future<Joke> getJokeOfTheDay() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    final Map<String, dynamic> data = json.decode(response.body);
    return Joke.fromJson(data);
  }
}