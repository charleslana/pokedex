import 'package:flutter/material.dart';

class ConstantsApp {
  static const String imagePokeballWhite = 'assets/images/pokeball_white.png';
  static const String imagePokeballDark = 'assets/images/pokeball_dark.png';
  static const String loadingPokeball = 'assets/images/pokeball_loading.png';
  static const String baseURL =
      'https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/pokedex.json';

  Color? getColorType(String type) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fighting':
        return Colors.orange;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}
