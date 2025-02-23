import 'package:flutter/material.dart';
import '../settings.dart' as settings;

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
      duration: Duration(milliseconds: 500),
    );

    pokemonFillColorAnim = ColorTween(begin: Colors.black, end: null)
        .animate(pokemonAnimController);

    pokemonFillColorAnim.addListener(() {
      setState(() {});
    });

    pokemonFillColorAnim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        pokemonAnimController.reset();
      }
    });

    pokemonAnimController.forward();

    super.initState();
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
