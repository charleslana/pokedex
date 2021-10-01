import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

class MovesetPokeDetails extends StatelessWidget {
  const MovesetPokeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokeDetailsController pokeDetailsController =
        Get.put(PokeDetailsController());
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());

    return Obx(() {
      final Pokemon pokemon =
          pokeHomeController.pokeList[pokeDetailsController.index];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pokemon.moves.en.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: Icon(
                Icons.star_border_outlined,
                color: AppConstants().getColorType(pokemon.type.en[0]),
              ),
              title: Text('languageCode'.tr == 'en'
                  ? pokemon.moves.en[index]
                  : pokemon.moves.ptBr[index]),
            );
          },
        ),
      );
    });
  }
}
