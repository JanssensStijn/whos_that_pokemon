import 'package:flutter/material.dart';
import '../settings.dart' as settings;

class Result extends StatelessWidget {
  final int score;

  const Result(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 60,
          child: Center(
              child: Text(
            "Resultaat: ",
            style: theme.textTheme.headlineMedium,
          )),
        ),
        Center(
            child: Text(
          score.toString(),
          style: theme.textTheme.headlineLarge,
        )),
        Center(
            child: Text(
          "van de ${settings.totalQuestions} vragen goed!",
          style: theme.textTheme.bodyLarge,
        )),
        Container(
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            child: ElevatedButton(
                child: Text("Opnieuw", style: theme.textTheme.bodyMedium),
                onPressed: () {
                  settings.restart.add(true);
                }))
      ],
    );
  }
}
