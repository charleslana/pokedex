import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/routes/app_route_generator.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Pokédex',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 50,
                      left: width - 175,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () => Get.toNamed<dynamic>(AppRoutes.menu),
                          icon: const Icon(Icons.menu),
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: width * 0.75,
                child: Autocomplete<Pokemon>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    pokeHomeController.notFoundPokemon.value = false;
                    final List<Pokemon> listPokemon = pokeHomeController
                        .pokeList
                        .where((Pokemon content) => content.name
                            .trim()
                            .toLowerCase()
                            .startsWith(
                                textEditingValue.text.trim().toLowerCase()))
                        .toList();
                    if (listPokemon.isEmpty) {
                      pokeHomeController.notFoundPokemon.value = true;
                    }
                    return listPokemon;
                  },
                  displayStringForOption: (Pokemon option) => option.name,
                  fieldViewBuilder: (_,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return Obx(() {
                      return TextFormField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        onFieldSubmitted: (String value) => onFieldSubmitted(),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'pokeHomeSearchPokemon'.tr,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (pokeHomeController.filterPokeList !=
                                  pokeHomeController.pokeList) {
                                pokeHomeController.filterPokeList
                                  ..clear()
                                  ..addAll(pokeHomeController.pokeList);
                              }
                              fieldTextEditingController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          errorText: pokeHomeController.notFoundPokemon.value
                              ? 'pokeHomeNoPokemonFound'.tr
                              : null,
                        ),
                      );
                    });
                  },
                  onSelected: (Pokemon selected) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    pokeHomeController.filterPokemon(selected);
                  },
                  optionsViewBuilder: (_,
                      AutocompleteOnSelected<Pokemon> onSelected,
                      Iterable<Pokemon> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: width * 0.50,
                          height: width * 0.2 * options.length * 1,
                          color: Colors.grey.withOpacity(0.2),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
