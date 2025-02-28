import 'package:flutter/material.dart';
import '../settings.dart' as settings;

// Define a GlobalKey for _MyPokemonState
final GlobalKey<_MyPokemonState> pokemonKey = GlobalKey<_MyPokemonState>();

class Pokemon extends StatefulWidget {
  final bool isCorrect;
  final String pokemonImage;

  const Pokemon(this.isCorrect, this.pokemonImage, {super.key});

  @override
  State<Pokemon> createState() => _MyPokemonState();
}

class _MyPokemonState extends State<Pokemon>
    with SingleTickerProviderStateMixin {
  late AnimationController pokemonAnimController;
  late Animation<Color?> pokemonFillColorAnim;

  @override
  void initState() {
    pokemonAnimController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    pokemonFillColorAnim = ColorTween(begin: Colors.black, end: null).animate(
      CurvedAnimation(
        parent: pokemonAnimController,
        curve: Interval(0.0, 0.3,
            curve: Curves.linear), // 60% of the time to reach the end color
      ),
    );

    pokemonFillColorAnim.addListener(() {
      setState(() {});
    });

    pokemonFillColorAnim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        pokemonAnimController.reset();
      }
    });

    super.initState();
  }

  void startAnimation() {
    pokemonAnimController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(settings.margin),
      child: Image.network(
        widget.pokemonImage,
        scale: 0.3,
        color: pokemonFillColorAnim.value,
      ),
    );
  }
}
