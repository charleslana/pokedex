import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/pages/poke-details/widgets/app_bar_poke_details.dart';
import 'package:pokedex/src/pages/poke-details/widgets/tab_bar_poke_details.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailsPage extends StatelessWidget {
  const PokeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final PokeDetailsController pokeDetailsController =
        Get.put(PokeDetailsController());
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());

    return Obx(() {
      final Pokemon pokemon =
          pokeHomeController.pokeList[pokeDetailsController.index];

      return SafeArea(
        child: Scaffold(
          appBar: const AppBarPokeDetails(),
          body: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: double.infinity,
                height: height / 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants().getColorType(pokemon.type.en[0])!,
                      if (pokemon.type.en.length > 1)
                        AppConstants().getColorType(pokemon.type.en[1])!
                      else
                        AppConstants().getColorType(pokemon.type.en[0])!,
                    ],
                    stops: const [0, 1],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),
                child: Opacity(
                  opacity: pokeDetailsController.opacity.value,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          pokemon.name,
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            listTypes(pokemon.type.en),
                            Text(
                              pokemon.num,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SlidingSheet(
                listener: (state) =>
                    pokeDetailsController.changeSlidingSheet(state.progress),
                cornerRadius: 30,
                snapSpec: const SnapSpec(
                  snappings: [0.6, 1.0],
                ),
                builder: (_, __) {
                  return SizedBox(
                    height: height,
                    child: const TabBarPokeDetails(),
                  );
                },
              ),
              IgnorePointer(
                ignoring: pokeDetailsController.opacityAppBarTitle.value == 1,
                child: Opacity(
                  opacity: pokeDetailsController.opacity.value,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 60 - pokeDetailsController.progress.value * 50),
                    child: SizedBox(
                      height: height / 3.2,
                      child: PageView.builder(
                        controller: pokeDetailsController.pageController.value,
                        onPageChanged: (int index) {
                          pokeDetailsController.index = index;
                          pokeDetailsController.tabController.animateTo(0);
                        },
                        physics: const BouncingScrollPhysics(),
                        itemCount: pokeHomeController.pokeList.length,
                        itemBuilder: (_, int index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedBuilder(
                                animation:
                                    pokeDetailsController.animationController,
                                builder: (_, child) {
                                  return Transform.rotate(
                                    angle: pokeDetailsController
                                            .animationController.value *
                                        2 *
                                        math.pi,
                                    child: child,
                                  );
                                },
                                child: Opacity(
                                  opacity: 0.2,
                                  child: Image.asset(
                                    AppConstants.imagePokeballWhite,
                                    height: height / 3.2,
                                  ),
                                ),
                              ),
                              AnimatedPadding(
                                duration: const Duration(milliseconds: 400),
                                padding: EdgeInsets.all(
                                    pokeDetailsController.index == index
                                        ? 0
                                        : 20),
                                curve: Curves.bounceInOut,
                                child: Hero(
                                  tag: index,
                                  child: CachedNetworkImage(
                                    placeholder: (_, __) => const Center(
                                      child: PokeLoading(),
                                    ),
                                    color: pokeDetailsController.index == index
                                        ? null
                                        : Colors.black.withOpacity(0.5),
                                    imageUrl:
                                        pokeHomeController.pokeList[index].img,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget listTypes(List<String> types) {
    final List<Widget> listWidgets = [];

    for (final name in types) {
      listWidgets.add(
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  name.trim(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidgets,
    );
  }
}
