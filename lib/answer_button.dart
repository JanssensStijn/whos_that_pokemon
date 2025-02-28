import 'package:flutter/material.dart';
import '../settings.dart' as settings;

// Define a GlobalKey for _MyAnswerButtonState
final GlobalKey<_MyAnswerButtonState> answerButtonKey =
    GlobalKey<_MyAnswerButtonState>();

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
  late bool enabled = true;
  late bool visible = true;

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
        visible = false;
      }
    });
    super.initState();
    enabled = true;
  }

  void startAnimation() {
    enabled = false;
    Color endColor;
    if (widget.isCorrect) {
      endColor = Colors.green;
    } else {
      endColor = Colors.red;
    }
    fillColorAnim =
        ColorTween(begin: Colors.blue, end: endColor).animate(animController);
    borderColorAnim = ColorTween(begin: Colors.blue[100], end: endColor)
        .animate(animController);
    animController.forward();
  }

  enableButton() {
    enabled = true;
    visible = true;
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.4;
    var theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(settings.margin),
        child: !visible ? null : GestureDetector(
          onTap: enabled
              ? () {
                  startAnimation();
                }
              : null,
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
