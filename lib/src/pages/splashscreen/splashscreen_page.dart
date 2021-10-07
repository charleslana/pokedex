import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/routes/app_route_generator.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () => Get.offNamed<dynamic>(AppRoutes.home),
    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            AppConstants.imageSplashscreen,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
