import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/routes/app_route_generator.dart';
import 'package:pokedex/src/translation/app_translation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation().translationsKeys,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Pokédex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ProductSans',
      ),
      initialRoute: AppRoutes.home,
      defaultTransition: Transition.fade,
      onGenerateRoute: AppRouteGenerator().generateRoute,
    );
  }
}
