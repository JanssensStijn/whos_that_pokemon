import 'package:flutter/material.dart';
import '../settings.dart' as settings;

class AnswerButton extends StatefulWidget {
  final bool isCorrect;
  final Function(bool) processAnswer;

  const AnswerButton(this.isCorrect, this.processAnswer, {super.key});

  @override
  State<AnswerButton> createState() => _MyAnswerButtonState();
}

class _MyAnswerButtonState extends State<AnswerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<Color?> fillColorAnim, borderColorAnim;
  late Animation<double?> fadeAnim;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    fillColorAnim = ColorTween(begin: Colors.blue).animate(animController);
    borderColorAnim =
        ColorTween(begin: Colors.blue[100]).animate(animController);
    fadeAnim = Tween<double>(begin: 1, end: 0.3).animate(animController);

    fillColorAnim.addListener(() {
      setState(() {});
    });

    fillColorAnim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.processAnswer(widget.isCorrect);
        animController.reset();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.4;
    var theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(settings.margin),
        child: GestureDetector(
          onTap: () {
            Color endColor;
            if (widget.isCorrect) {
              endColor = Colors.green;
            } else {
              endColor = Colors.red;
            }
            fillColorAnim = ColorTween(begin: Colors.blue, end: endColor)
                .animate(animController);
            borderColorAnim = ColorTween(begin: Colors.blue[100], end: endColor)
                .animate(animController);
            animController.forward();
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: buttonWidth * 0.5,
              minWidth: buttonWidth,
              maxWidth: buttonWidth,
            ),
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: fillColorAnim.value!,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1.0,
                      )
                    ],
                    border: Border.all(
                      color: borderColorAnim.value!,
                      width: 2,
                    )),
                child: Center(
                    child: Text(
                  'Catch!',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ))),
          ),
        ));
  }
}
