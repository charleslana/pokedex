import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/theme_controller.dart';

class TabDarkTheme extends StatelessWidget {
  const TabDarkTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return Center(
        child: Switch(
          onChanged: (_) => themeController.changeThemeMode(),
          value: themeController.isDarkMode.value,
        ),
      );
    });
  }
}
