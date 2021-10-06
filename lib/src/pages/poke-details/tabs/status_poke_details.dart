import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
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
                Text(
                  'pokeDetailsAttack'.tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  pokemon.atk.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: 4,
              alignment: Alignment.centerLeft,
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Colors.grey,
              ),
              child: FractionallySizedBox(
                widthFactor: pokemon.atk / maxStatusBar,
                heightFactor: 1,
                child: Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: Colors.red[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'pokeDetailsDefense'.tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  pokemon.def.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: 4,
              alignment: Alignment.centerLeft,
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Colors.grey,
              ),
              child: FractionallySizedBox(
                widthFactor: pokemon.def / maxStatusBar,
                heightFactor: 1,
                child: Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: Colors.green[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'pokeDetailsStamina'.tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  pokemon.sta.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: 4,
              alignment: Alignment.centerLeft,
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Colors.grey,
              ),
              child: FractionallySizedBox(
                widthFactor: pokemon.sta / maxStatusBar,
                heightFactor: 1,
                child: Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
