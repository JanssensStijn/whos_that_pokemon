import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whos_that_pokemon/answer_button.dart';
import 'package:whos_that_pokemon/pokemon.dart';
import 'settings.dart' as settings;
import 'package:http/http.dart' as http;
import 'package:whos_that_pokemon/question.dart';
import 'package:whos_that_pokemon/result.dart';
import 'dart:convert';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _MyQuizState();
}

class _MyQuizState extends State<Quiz> with AutomaticKeepAliveClientMixin {
  int questionNumber = 0;
  int score = 0;
  Set<int> alreadyUsedPokemon = {};

  @override
  void initState() {
    super.initState();
    settings.settings.restart.listen((event) {
      setState(() {
        questionNumber = 0;
        score = 0;
        alreadyUsedPokemon.clear();
      });
    });
  }

  void processAnswer(bool isCorrect) {
    answerButtonKey.currentState?.startAnimation();
    pokemonKey.currentState?.startAnimation();

    Future.delayed(const Duration(seconds: 3), () {
      if (isCorrect) {
        score++;
      }
      setState(() {
        questionNumber++;
      });
    });
  }

  int getRandomPokemonId() {
    int randomId;
    if (settings.maxPokemonId != alreadyUsedPokemon.length) {
      do {
        randomId = Random().nextInt(settings.maxPokemonId) + 1;
      } while (alreadyUsedPokemon.contains(randomId));
      alreadyUsedPokemon.add(randomId);
      return randomId;
    } else {
      throw Exception('No more pokémon');
    }
  }

  Future<http.Response> fetchPokemon(id) {
    return http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (questionNumber == settings.totalQuestions) {
      return Result(score);
    } else {
      return FutureBuilder<http.Response>(
        future: fetchPokemon(getRandomPokemonId()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var pokemon = jsonDecode(snapshot.data?.body ?? '');
            return Question(pokemon, questionNumber, score, processAnswer);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/background.jpeg"), // Correct path
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: const CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
