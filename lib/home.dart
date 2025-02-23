import 'package:flutter/material.dart';
import 'package:whos_that_pokemon/quiz.dart';
import 'settings.dart' as settings;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(settings.margin),
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
                    child: GestureDetector(
                      onTap: () {
                        settings.Settings().restartQuiz();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Quiz()),
                        );
                      },
                      child: Image.asset(
                        "assets/images/start.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
