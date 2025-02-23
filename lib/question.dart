import 'package:flutter/material.dart';
import 'package:whos_that_pokemon/answer_button.dart';
import 'package:whos_that_pokemon/pokemon.dart';
import 'settings.dart' as settings;

class Question extends StatefulWidget {
  final Map<String, dynamic> pokemon;
  final int questionNumber;
  final int pokemonsCaught;
  final Function processAnswer;

  const Question(this.pokemon, this.questionNumber, this.pokemonsCaught,
      this.processAnswer,
      {super.key});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String pokemonGuess = '';
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"), // Correct path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(settings.margin),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/title.png",
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(50, 0, 0, 255),
                        spreadRadius: 15,
                        blurRadius: 30,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Pokemon(
                      isCorrect, widget.pokemon['sprites']['front_default']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                    onChanged: (value) {
                      setState(() {
                        pokemonGuess = value;
                      });
                    },
                    autofocus: true,
                    keyboardType: TextInputType.text,
                  ),
                ),
                AnswerButton(
                    pokemonGuess.toLowerCase() == widget.pokemon['name'],
                    widget.processAnswer)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
