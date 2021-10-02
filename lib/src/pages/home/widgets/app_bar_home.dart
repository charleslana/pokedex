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

    return SizedBox(
      height: 150,
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: width * 0.50,
                      child: Autocomplete<Pokemon>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return pokeHomeController.pokeList
                              .where((Pokemon content) => content.name
                                  .toLowerCase()
                                  .startsWith(
                                      textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (Pokemon option) => option.name,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Search pokémon',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  pokeHomeController.filterPokeList =
                                      pokeHomeController.pokeList;
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          );
                        },
                        onSelected: pokeHomeController.filterPokemon,
                        optionsViewBuilder: (_,
                            AutocompleteOnSelected<Pokemon> onSelected,
                            Iterable<Pokemon> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                width: width * 0.50,
                                color: Colors.grey.withOpacity(0.2),
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: options.length,
                                  itemBuilder: (_, int index) {
                                    final Pokemon option =
                                        options.elementAt(index);

                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(
                                          option.name,
                                          style: const TextStyle(
                                              color: Colors.black),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
