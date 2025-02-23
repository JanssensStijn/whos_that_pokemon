import 'package:flutter/material.dart';
import 'package:whos_that_pokemon/home.dart';
import 'package:whos_that_pokemon/quiz.dart';
import '../settings.dart' as settings;

class Result extends StatelessWidget {
  final int score;

  const Result(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage("assets/images/background.jpeg"), // Correct path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/title.png",
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Text(
                          "You caught: ",
                          style: theme.textTheme.headlineMedium,
                        ),
                        Text(
                          score.toString(),
                          style: theme.textTheme.headlineLarge,
                        ),
                        Text(
                          "out of ${settings.totalQuestions} pokemon that appeared!",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.yellow),
                              side: WidgetStateProperty.all<BorderSide>(
                                  BorderSide(color: Colors.blue, width: 3)),
                            ),
                            onPressed: () {
                              settings.Settings().restartQuiz();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Quiz()),
                              );
                            },
                            child: Text("Try again",
                                style: theme.textTheme.bodyMedium),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.yellow),
                              side: WidgetStateProperty.all<BorderSide>(
                                  BorderSide(color: Colors.blue, width: 3)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            },
                            child: Text("Back to home",
                                style: theme.textTheme.bodyMedium),
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
