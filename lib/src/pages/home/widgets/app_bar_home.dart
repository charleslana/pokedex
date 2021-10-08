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
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Autocomplete<Pokemon>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        pokeHomeController.notFoundPokemon.value = false;
                        pokeHomeController.isSearch.value = true;

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

                        if (textEditingValue.text.trim().isNotEmpty) {
                          pokeHomeController.isSearch.value = false;
                        }

                        return listPokemon;
                      },
                      displayStringForOption: (Pokemon option) => option.name,
                      fieldViewBuilder: (_,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return Obx(() {
                          pokeHomeController.textEditingController =
                              fieldTextEditingController;

                          return TextFormField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            onFieldSubmitted: (String value) =>
                                onFieldSubmitted(),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'pokeHomeSearchPokemon'.tr,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (pokeHomeController
                                              .filterPokeList.length !=
                                          pokeHomeController.pokeList.length &&
                                      pokeHomeController.selectedIndex.value ==
                                          0) {
                                    pokeHomeController.filterPokeList
                                      ..clear()
                                      ..addAll(pokeHomeController.pokeList);
                                    pokeHomeController.selectedIndex.value = 0;
                                  }
                                  fieldTextEditingController.clear();
                                  pokeHomeController.isSearch.value = true;
                                },
                                icon: Icon(pokeHomeController.isSearch.value
                                    ? Icons.search
                                    : Icons.clear),
                              ),
                              errorText:
                                  pokeHomeController.notFoundPokemon.value
                                      ? 'pokeHomeSearchNoPokemonFound'.tr
                                      : null,
                            ),
                          );
                        });
                      },
                      onSelected: (Pokemon selected) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        pokeHomeController.filterPokemon(selected);
                        pokeHomeController.isSearch.value = false;
                      },
                      optionsViewBuilder: (_,
                          AutocompleteOnSelected<Pokemon> onSelected,
                          Iterable<Pokemon> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: width * 0.50,
                              height: 60 * options.length * 1,
                              color: Colors.grey[400],
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text('pokeHomeFilter'.tr),
              Expanded(
                child: Obx(() {
                  return _buildFilters(pokeHomeController);
                }),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFilters(PokeHomeController pokeHomeController) {
    final List<Widget> chips = [];
    final List<String> _options = [
      'pokeHomeFilterAll'.tr,
      'pokeHomeFilterTypeNormal'.tr,
      'pokeHomeFilterTypeFighting'.tr,
      'pokeHomeFilterTypeFlying'.tr,
      'pokeHomeFilterTypePoison'.tr,
      'pokeHomeFilterTypeGround'.tr,
      'pokeHomeFilterTypeRock'.tr,
      'pokeHomeFilterTypeBug'.tr,
      'pokeHomeFilterTypeGhost'.tr,
      'pokeHomeFilterTypeSteel'.tr,
      'pokeHomeFilterTypeFire'.tr,
      'pokeHomeFilterTypeWater'.tr,
      'pokeHomeFilterTypeGrass'.tr,
      'pokeHomeFilterTypeElectric'.tr,
      'pokeHomeFilterTypePsychic'.tr,
      'pokeHomeFilterTypeIce'.tr,
      'pokeHomeFilterTypeDragon'.tr,
      'pokeHomeFilterTypeDark'.tr,
      'pokeHomeFilterTypeFairy'.tr,
    ];

    for (int index = 0; index < _options.length; index++) {
      final ChoiceChip choiceChip = ChoiceChip(
          selected: pokeHomeController.selectedIndex.value == index,
          label: Text(
            _options[index],
            style: const TextStyle(color: Colors.white),
          ),
          elevation: 0,
          pressElevation: 5,
          backgroundColor: Colors.black54,
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            if (pokeHomeController.selectedIndex.value != index) {
              pokeHomeController.changeFilter(index, _options[index]);
              pokeHomeController.textEditingController.clear();
            }
          });

      chips.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: choiceChip,
        ),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
}
