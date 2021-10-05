import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_loading_controller.dart';

class PokeLoading extends StatelessWidget {
  const PokeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokeLoadingController pokeLoadingController =
        Get.put(PokeLoadingController());

    return AnimatedBuilder(
      animation: pokeLoadingController.animationController,
      builder: (_, child) {
        return Transform.rotate(
          angle: pokeLoadingController.animationController.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image.asset(
        AppConstants.loadingPokeball,
        height: 42,
      ),
    );
  }
}
