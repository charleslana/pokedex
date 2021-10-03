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
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'pokeDetailsResistance'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'pokeDetailsWeaknesses'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
          rows: listTypes(pokemon),
        ),
      );
    });
  }

  List<DataRow> listTypes(Pokemon pokemon) {
    final List<DataRow> listDataRow = [];
    List<String> typesResistant = [];
    List<String> typesWeaknesses = [];

    if ('languageCode'.tr == 'en') {
      typesResistant = pokemon.resistant.en;
      typesWeaknesses = pokemon.weaknesses.en;
    } else {
      typesResistant = pokemon.resistant.ptBr;
      typesWeaknesses = pokemon.weaknesses.ptBr;
    }

    for (final name in typesResistant) {
      listDataRow.add(
        DataRow(
          cells: [
            DataCell(Text(name)),
            const DataCell(Text('-')),
          ],
        ),
      );
    }
    for (final name in typesWeaknesses) {
      listDataRow.add(
        DataRow(
          cells: [
            const DataCell(Text('-')),
            DataCell(Text(name)),
          ],
        ),
      );
    }
    return listDataRow;
  }
}
