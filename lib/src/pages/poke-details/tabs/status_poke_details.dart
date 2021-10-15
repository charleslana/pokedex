import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

class StatusPokeDetails extends StatelessWidget {
  const StatusPokeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokeDetailsController pokeDetailsController =
        Get.put(PokeDetailsController());
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());

    return Obx(() {
      final Pokemon pokemon =
          pokeHomeController.pokeList[pokeDetailsController.index];
      const double maxStatusBar = 345;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('pokeDetailsAttack'.tr),
                Text(
                  pokemon.atk.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 700,
              lineHeight: 6,
              percent: pokemon.atk / maxStatusBar,
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('pokeDetailsDefense'.tr),
                Text(
                  pokemon.def.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 700,
              lineHeight: 6,
              percent: pokemon.def / maxStatusBar,
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('pokeDetailsStamina'.tr),
                Text(
                  pokemon.sta.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 700,
              lineHeight: 6,
              percent: pokemon.sta / maxStatusBar,
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'pokeDetailsMaxCP'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(pokemon.maxCp.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
