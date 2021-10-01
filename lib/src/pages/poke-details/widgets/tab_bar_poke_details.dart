import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/pages/poke-details/views/about_poke_details.dart';
import 'package:pokedex/src/pages/poke-details/views/evolution_poke_details.dart';
import 'package:pokedex/src/pages/poke-details/views/moveset_poke_details.dart';
import 'package:pokedex/src/pages/poke-details/views/status_poke_details.dart';

class TabBarPokeDetails extends StatelessWidget {
  const TabBarPokeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokeDetailsController pokeDetailsController =
        Get.put(PokeDetailsController());
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());

    return Obx(() {
      final Pokemon pokemon =
          pokeHomeController.pokeList[pokeDetailsController.index];

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: AppConstants().getColorType(pokemon.type.en[0]),
            indicatorColor: AppConstants().getColorType(pokemon.type.en[0]),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(5),
            isScrollable: true,
            physics: const BouncingScrollPhysics(),
            onTap: (int index) {},
            enableFeedback: true,
            controller: pokeDetailsController.tabController,
            tabs: [
              Tab(text: 'pokeDetailsAbout'.tr),
              Tab(text: 'pokeDetailsEvolution'.tr),
              Tab(text: 'pokeDetailsStatus'.tr),
              Tab(text: 'pokeDetailsMoveset'.tr),
              Tab(text: 'pokeDetailsTypes'.tr),
              Tab(text: 'pokeDetailsSimulate'.tr),
            ],
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: pokeDetailsController.tabController,
          children: const [
            AboutPokeDetails(),
            EvolutionPokeDetails(),
            StatusPokeDetails(),
            MovesetPokeDetails(),
            Text('Types'),
            Text('Simulate'),
          ],
        ),
      );
    });
  }
}
