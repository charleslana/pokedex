import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pokedex/src/constants/app_constants.dart';

class PokeLoading extends StatefulWidget {
  const PokeLoading({Key? key}) : super(key: key);

  @override
  _PokeLoadingState createState() => _PokeLoadingState();
}

class _PokeLoadingState extends State<PokeLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image.asset(
        AppConstants.loadingPokeball,
        width: 42,
      ),
    );
  }
}
