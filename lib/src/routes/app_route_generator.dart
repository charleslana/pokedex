import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/pages/home/home_page.dart';
import 'package:pokedex/src/pages/poke-details/poke_details_page.dart';

part 'app_routes.dart';

class AppRouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return GetPageRoute(
          page: () => const HomePage(),
          transition: Transition.fade,
        );
      case AppRoutes.pokeDetails:
        return GetPageRoute(
          page: () => const PokeDetailsPage(),
          transition: Transition.fade,
        );
      default:
        return GetPageRoute(
          page: () => Scaffold(
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
