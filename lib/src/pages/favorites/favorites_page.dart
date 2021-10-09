import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_grid_view.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/controllers/db_controller.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DBController dbController = Get.put(DBController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text('favoritesTitle'.tr),
        ),
        body: Obx(() {
          return dbController.isLoading.value
              ? const Center(child: PokeLoading())
              : dbController.favoriteList.isEmpty
                  ? Center(
                      child: Text('favoritesNoPokemon'.tr),
                    )
                  : PokeGridView(pokeList: dbController.favoriteList);
        }),
      ),
    );
  }
}
