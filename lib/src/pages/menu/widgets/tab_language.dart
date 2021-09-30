import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/menu_controller.dart';
import 'package:pokedex/src/models/language_model.dart';

class TabLanguage extends StatelessWidget {
  const TabLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());
    final List<Widget> chips = [];

    for (int i = 0; i < languages.length; i++) {
      final FilterChip filterChip = FilterChip(
        selected: menuController.selected[i],
        label: Text(
          languages[i].language,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 10,
        pressElevation: 5,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) =>
            menuController.changeLanguage(languages[i].symbol, i),
      );

      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: filterChip,
      ));
    }

    return Center(
      child: Wrap(
        children: chips,
      ),
    );
  }
}
