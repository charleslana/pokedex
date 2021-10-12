import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

class ToComparePokeDetails extends StatelessWidget {
  const ToComparePokeDetails({Key? key}) : super(key: key);

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
          children: [
            Text('pokeDetailsToCompareDescription'
                .trParams({'pokemonName': pokemon.name})),
            const SizedBox(
              height: 10,
            ),
            Autocomplete<Pokemon>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                pokeDetailsController.notFoundPokemon.value = false;
                pokeDetailsController.isSelected.value = true;

                final List<Pokemon> listPokemon = pokeHomeController.pokeList
                    .where((Pokemon content) => content.name
                        .trim()
                        .toLowerCase()
                        .startsWith(textEditingValue.text.trim().toLowerCase()))
                    .toList();
                if (listPokemon.isEmpty) {
                  pokeDetailsController.notFoundPokemon.value = true;
                }

                if (textEditingValue.text.trim().isNotEmpty) {
                  pokeDetailsController.isSelected.value = false;
                }

                return listPokemon;
              },
              displayStringForOption: (Pokemon option) => option.name,
              fieldViewBuilder: (_,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return Obx(() {
                  pokeDetailsController.textEditingController =
                      fieldTextEditingController;

                  return TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    onFieldSubmitted: (String value) => onFieldSubmitted(),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'pokeDetailsToCompareLabelText'.tr,
                      suffixIcon: IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          fieldTextEditingController.clear();
                          pokeDetailsController.isSelected.value = true;
                        },
                        icon: Icon(pokeDetailsController.isSelected.value
                            ? Icons.search
                            : Icons.clear),
                      ),
                      errorText: pokeDetailsController.notFoundPokemon.value
                          ? 'pokeHomeSearchNoPokemonFound'.tr
                          : null,
                    ),
                  );
                });
              },
              onSelected: (Pokemon selected) {
                FocusManager.instance.primaryFocus?.unfocus();
                pokeDetailsController.toComparePokemon(pokemon, selected);
                pokeDetailsController.isSelected.value = false;
              },
              optionsViewBuilder: (_,
                  AutocompleteOnSelected<Pokemon> onSelected,
                  Iterable<Pokemon> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: Get.width * 0.50,
                      height: 60 * options.length * 1,
                      color: Colors.grey[400],
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: options.length,
                        itemBuilder: (_, int index) {
                          final Pokemon option = options.elementAt(index);

                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(
                                option.name,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
