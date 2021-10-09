import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/src/routes/app_route_generator.dart';
import 'package:pokedex/src/services/language_service.dart';
import 'package:pokedex/src/services/theme_service.dart';
import 'package:pokedex/src/translation/app_translation.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation().translationsKeys,
      locale: LanguageService().locale ?? Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Pokémax',
      theme: light,
      darkTheme: dark,
      themeMode: ThemeService().theme,
      initialRoute: AppRoutes.splashscreen,
      defaultTransition: Transition.fade,
      onGenerateRoute: AppRouteGenerator().generateRoute,
    );
  }
}
