import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_animated_controller.dart';

class PokeAnimated extends StatelessWidget {
  const PokeAnimated({
    required this.image,
    required this.height,
    Key? key,
  }) : super(key: key);

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    final PokeAnimatedController pokeAnimatedController =
        Get.put(PokeAnimatedController());

    return AnimatedBuilder(
      animation: pokeAnimatedController.animationController,
      builder: (_, child) {
        return Transform.rotate(
          angle: pokeAnimatedController.animationController.value * 2 * math.pi,
          child: child,
        );
      },
      child: Opacity(
        opacity: 0.2,
        child: Image.asset(
          image,
          height: height,
        ),
      ),
    );
  }
}
