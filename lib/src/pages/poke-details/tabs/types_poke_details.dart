import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

class TypesPokeDetails extends StatelessWidget {
  const TypesPokeDetails({Key? key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'pokeDetailsResistance'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: pokemon.resistant.en.map((element) {
                final int index = pokemon.resistant.en.indexOf(element);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'languageCode'.tr == 'en'
                          ? pokemon.resistant.en[index]
                          : pokemon.resistant.ptBr[index],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              'pokeDetailsWeaknesses'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: pokemon.weaknesses.en.map((element) {
                final int index = pokemon.weaknesses.en.indexOf(element);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'languageCode'.tr == 'en'
                          ? pokemon.weaknesses.en[index]
                          : pokemon.weaknesses.ptBr[index],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}
