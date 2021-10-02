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
        child: IgnorePointer(
          ignoring: pokeDetailsController.opacityAppBarTitle.value == 0,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Resistance',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Weaknesses',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: listTypes(pokemon),
            ),
          ),
        ),
      );
    });
  }

  List<DataRow> listTypes(Pokemon pokemon) {
    final List<DataRow> listDataRow = [];

    for (final name in pokemon.resistant.en) {
      listDataRow.add(
        DataRow(
          cells: [
            DataCell(Text(name)),
            const DataCell(Text('-')),
          ],
        ),
      );
    }
    for (final name in pokemon.weaknesses.en) {
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
