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

    for (int index = 0; index < languages.length; index++) {
      final ChoiceChip choiceChip = ChoiceChip(
        selected: menuController.selectedIndex.value == index,
        label: Text(
          index == 0 ? 'languageEnglish'.tr : 'languagePortuguese'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 10,
        pressElevation: 5,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) =>
            menuController.changeLanguage(languages[index].symbol, index),
      );

      chips.add(choiceChip);
    }

    return Center(
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: chips,
      ),
    );
  }
}
