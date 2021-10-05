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
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: pokemon.moves.en.map((element) {
            final int index = pokemon.moves.en.indexOf(element);

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppConstants().getColorType(pokemon.type.en[0]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'languageCode'.tr == 'en'
                      ? pokemon.moves.en[index]
                      : pokemon.moves.ptBr[index],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
