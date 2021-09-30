import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/widgets/menu_widget.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Pokédex',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).padding.top + 50,
                  left: MediaQuery.of(context).size.width - 175,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      onPressed: () => Get.dialog<dynamic>(const MenuWidget()),
                      icon: const Icon(Icons.menu),
                      iconSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
