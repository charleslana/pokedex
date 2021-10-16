import 'package:flutter/material.dart';

class AppConstants {
  static const String imagePokeballWhite = 'assets/images/pokeball_white.png';
  static const String imagePokeballDark = 'assets/images/pokeball_dark.png';
  static const String loadingPokeball = 'assets/images/pokeball_loading.png';
  static const String imageSplashscreen = 'assets/images/pokemax.png';
  static const String baseURL =
      'https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/api.json';

  Color? getColorType(String type) {
    switch (type) {
      case 'Normal':
        return const Color(0xffa8a878);
      case 'Fire':
        return const Color(0xfff08030);
      case 'Water':
        return const Color(0xff6890f0);
      case 'Grass':
        return const Color(0xff78c850);
      case 'Electric':
        return const Color(0xfff8d030);
      case 'Ice':
        return const Color(0xff98d8d8);
      case 'Fighting':
        return const Color(0xffc02038);
      case 'Poison':
        return const Color(0xffa040a0);
      case 'Ground':
        return const Color(0xffe0c068);
      case 'Flying':
        return const Color(0xffa890f0);
      case 'Psychic':
        return const Color(0xfff85888);
      case 'Bug':
        return const Color(0xffa8b820);
      case 'Rock':
        return const Color(0xffb8a038);
      case 'Ghost':
        return const Color(0xff705898);
      case 'Dark':
        return const Color(0xff705848);
      case 'Dragon':
        return const Color(0xff7038f8);
      case 'Steel':
        return const Color(0xffb8b8d0);
      case 'Fairy':
        return const Color(0xffee99ac);
      default:
        return Colors.grey;
    }
  }

  String getImageType(String type) {
    switch (type) {
      case 'Normal':
        return 'assets/images/types/normal.png';
      case 'Fire':
        return 'assets/images/types/fire.png';
      case 'Fogo':
        return 'assets/images/types/fire.png';
      case 'Water':
        return 'assets/images/types/water.png';
      case 'Água':
        return 'assets/images/types/water.png';
      case 'Grass':
        return 'assets/images/types/grass.png';
      case 'Planta':
        return 'assets/images/types/grass.png';
      case 'Electric':
        return 'assets/images/types/electric.png';
      case 'Elétrico':
        return 'assets/images/types/electric.png';
      case 'Ice':
        return 'assets/images/types/ice.png';
      case 'Gelo':
        return 'assets/images/types/ice.png';
      case 'Fighting':
        return 'assets/images/types/fighting.png';
      case 'Lutador':
        return 'assets/images/types/fighting.png';
      case 'Poison':
        return 'assets/images/types/poison.png';
      case 'Veneno':
        return 'assets/images/types/poison.png';
      case 'Ground':
        return 'assets/images/types/ground.png';
      case 'Terrestre':
        return 'assets/images/types/ground.png';
      case 'Flying':
        return 'assets/images/types/flying.png';
      case 'Voador':
        return 'assets/images/types/flying.png';
      case 'Psychic':
        return 'assets/images/types/psychic.png';
      case 'Psíquico':
        return 'assets/images/types/psychic.png';
      case 'Bug':
        return 'assets/images/types/bug.png';
      case 'Inseto':
        return 'assets/images/types/bug.png';
      case 'Rock':
        return 'assets/images/types/rock.png';
      case 'Pedra':
        return 'assets/images/types/rock.png';
      case 'Ghost':
        return 'assets/images/types/ghost.png';
      case 'Fantasma':
        return 'assets/images/types/ghost.png';
      case 'Dark':
        return 'assets/images/types/dark.png';
      case 'Sombrio':
        return 'assets/images/types/dark.png';
      case 'Dragon':
        return 'assets/images/types/dragon.png';
      case 'Dragão':
        return 'assets/images/types/dragon.png';
      case 'Steel':
        return 'assets/images/types/steel.png';
      case 'Aço':
        return 'assets/images/types/steel.png';
      case 'Fairy':
        return 'assets/images/types/fairy.png';
      case 'Fada':
        return 'assets/images/types/fairy.png';
      default:
        return 'assets/images/types/normal.png';
    }
  }
}
