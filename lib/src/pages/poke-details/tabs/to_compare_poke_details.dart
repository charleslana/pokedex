import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pokedex/src/components/poke_animated.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/theme_service.dart';

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
                pokeDetailsController.sheetController.expand();
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
                          pokeDetailsController
                            ..isSelected.value = true
                            ..isVisible.value = false;
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
                    child: SizedBox(
                      width: Get.width * 0.75,
                      height: 60 * options.length * 1,
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
                              leading: CircleAvatar(
                                child: CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  placeholder: (_, __) => const Center(
                                    child: PokeLoading(),
                                  ),
                                  imageUrl: option.img,
                                ),
                              ),
                              title: Text(option.name),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: pokeDetailsController.isVisible.value,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              if (ThemeService().theme == ThemeMode.light)
                                const PokeAnimated(
                                  image: AppConstants.imagePokeballDark,
                                  height: 80,
                                )
                              else
                                const PokeAnimated(
                                  image: AppConstants.imagePokeballWhite,
                                  height: 80,
                                ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CachedNetworkImage(
                                  placeholder: (_, __) => const Center(
                                    child: PokeLoading(),
                                  ),
                                  imageUrl: pokemon.img,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                            child: Text(
                              pokemon.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Stack(
                            children: [
                              if (ThemeService().theme == ThemeMode.light)
                                const PokeAnimated(
                                  image: AppConstants.imagePokeballDark,
                                  height: 80,
                                )
                              else
                                const PokeAnimated(
                                  image: AppConstants.imagePokeballWhite,
                                  height: 80,
                                ),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CachedNetworkImage(
                                  placeholder: (_, __) => const Center(
                                    child: PokeLoading(),
                                  ),
                                  imageUrl: pokeDetailsController
                                      .targetPokemon.value.img,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                            child: Text(
                              pokeDetailsController.targetPokemon.value.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: LinearPercentIndicator(
                          width: Get.width * 0.50,
                          animation: true,
                          animationDuration: 700,
                          lineHeight: 10,
                          percent: pokeDetailsController.chancePokemon / 100,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.blueAccent,
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${pokeDetailsController.chancePokemon.toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'pokeDetailsToCompareChanceOfVictory'.tr,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${pokeDetailsController.chanceTargetPokemon.toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'pokeDetailsToCompareChanceOfVictory'.tr,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      pokeDetailsController.toComparePokemonAll(
                          pokemon, pokeHomeController.pokeList);
                      Get.bottomSheet<dynamic>(
                        Container(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: pokeDetailsController.toCompareList
                                    .map((poke) {
                                  return IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                child: CachedNetworkImage(
                                                  placeholder: (_, __) =>
                                                      const Center(
                                                    child: PokeLoading(),
                                                  ),
                                                  imageUrl: pokemon.img,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    pokemon.name,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${poke.percentage.toStringAsFixed(0)}%',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: VerticalDivider(),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${(100 - poke.percentage).toStringAsFixed(0)}%',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                child: CachedNetworkImage(
                                                  placeholder: (_, __) =>
                                                      const Center(
                                                    child: PokeLoading(),
                                                  ),
                                                  imageUrl: poke.imageTarget,
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    poke.nameTarget,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text('pokeDetailsToCompareListTargets'.tr),
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
