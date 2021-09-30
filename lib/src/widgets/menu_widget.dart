import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pokedex/src/controllers/menu_controller.dart';
import 'package:pokedex/src/models/language_model.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());

    final List<Tab> tabs = [
      Tab(icon: const Icon(Icons.language), text: 'language'.tr),
      Tab(icon: const Icon(Icons.dark_mode), text: 'darkTheme'.tr),
      Tab(icon: const Icon(Icons.info), text: 'about'.tr),
    ];

    Widget tabLanguage() {
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
        bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
          indicatorWeight: 1,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5),
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          onTap: (int index) {},
          enableFeedback: true,
          controller: menuController.tabController,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: menuController.tabController,
        children: [
          tabLanguage(),
          const Text('Dark Theme'),
          const Text('About'),
        ],
      ),
    );
  }
}
