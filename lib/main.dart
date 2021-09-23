import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokédex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ProductSans',
      ),
      home: const HomePage(),
    );
  }
}
