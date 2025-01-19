import 'package:lab3/models/joke.dart';

class FavoriteJokes {
  static final List<Joke> _favorites = [];

  static List<Joke> get favorites => _favorites;

  static bool isFavorite(Joke joke) {
    return _favorites.any((favJoke) => favJoke.id == joke.id);
  }

  static void addFavorite(Joke joke) {
    if (!isFavorite(joke)) {
      _favorites.add(joke);
    }
  }

  static void removeFavorite(Joke joke) {
    _favorites.removeWhere((favJoke) => favJoke.id == joke.id);
  }
}
