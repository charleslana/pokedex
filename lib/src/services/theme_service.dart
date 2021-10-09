import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final GetStorage _box = GetStorage();
  final String _key = 'theme';
  late bool isDarkMode;

  ThemeMode get theme => _loadThemeFromBox() != null
      ? _loadThemeFromBox()!
          ? ThemeMode.dark
          : ThemeMode.light
      : MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                  .platformBrightness ==
              Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;

  bool? _loadThemeFromBox() => _box.read(_key);

  void _saveThemeToBox() => _box.write(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox();
  }
}

final ThemeData light = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'ProductSans',
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 21,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return Colors.white;
      },
    ),
    trackColor: MaterialStateProperty.all(Colors.black54),
  ),
);

final ThemeData dark = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  fontFamily: 'ProductSans',
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.white,
  ),
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return Colors.white;
      },
    ),
    trackColor: MaterialStateProperty.all(Colors.white54),
  ),
);
