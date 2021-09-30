import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/menu_controller.dart';
import 'package:pokedex/src/pages/menu/widgets/tab_language.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());

    final List<Tab> tabs = [
      Tab(icon: const Icon(Icons.language), text: 'menuLanguage'.tr),
      Tab(icon: const Icon(Icons.dark_mode), text: 'menuDarkTheme'.tr),
      Tab(icon: const Icon(Icons.info), text: 'menuAbout'.tr),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
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
        children: const [
          TabLanguage(),
          Text('Dark Theme'),
          Text('About'),
        ],
      ),
    );
  }
}
