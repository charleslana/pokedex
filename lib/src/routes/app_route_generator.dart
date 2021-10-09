import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/pages/favorites/favorites_page.dart';
import 'package:pokedex/src/pages/home/home_page.dart';
import 'package:pokedex/src/pages/menu/menu_page.dart';
import 'package:pokedex/src/pages/poke-details/poke_details_page.dart';
import 'package:pokedex/src/pages/splashscreen/splashscreen_page.dart';

part 'app_routes.dart';

class AppRouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashscreen:
        return GetPageRoute(
          page: () => const SplashscreenPage(),
          settings: settings,
        );
      case AppRoutes.home:
        return GetPageRoute(
          page: () => const HomePage(),
          settings: settings,
        );
      case AppRoutes.pokeDetails:
        return GetPageRoute(
          page: () => const PokeDetailsPage(),
          settings: settings,
        );
      case AppRoutes.menu:
        return GetPageRoute(
          page: () => const MenuPage(),
          settings: settings,
        );
      case AppRoutes.favorites:
        return GetPageRoute(
          page: () => const FavoritesPage(),
          settings: settings,
        );
      default:
        return GetPageRoute(
          page: () => SafeArea(
            child: Scaffold(
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            ),
          ),
        );
    }
  }
}
