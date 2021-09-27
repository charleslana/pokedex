import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/pages/home/home_page.dart';
import 'package:pokedex/src/pages/poke-details/poke_details_page.dart';
import 'package:pokedex/src/routes/app_routes.dart';
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
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => const HomePage(),
        ),
        GetPage(
          name: AppRoutes.pokeDetails,
          page: () => const PokeDetailsPage(),
        ),
      ],
    );
  }
}
