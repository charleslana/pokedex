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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    'Attack',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    'Defense',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    'Stamina',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    'CP',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    pokemon.atk.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    pokemon.def.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    pokemon.sta.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    pokemon.maxCp.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 4,
                    alignment: Alignment.centerLeft,
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.grey,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: pokemon.atk / 345,
                      heightFactor: 1,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: const StadiumBorder(),
                          color: Colors.red[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Container(
                    height: 4,
                    alignment: Alignment.centerLeft,
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.grey,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: pokemon.def / 396,
                      heightFactor: 1,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: const StadiumBorder(),
                          color: Colors.green[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Container(
                    height: 4,
                    alignment: Alignment.centerLeft,
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.grey,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: pokemon.sta / 496,
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
            ),
          ],
        ),
      );
    });
  }
}
