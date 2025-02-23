import 'dart:async';

class Settings {
  final StreamController<void> _restartController = StreamController<void>.broadcast();
  Stream<void> get restart => _restartController.stream;

  void restartQuiz() {
    _restartController.add(null);
  }
}

final settings = Settings();

const double margin = 10;
const int maxPokemonId = 150;
const int totalQuestions = 10;