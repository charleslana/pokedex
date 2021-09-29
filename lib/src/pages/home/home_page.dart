import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/pages/home/widgets/app_bar_home.dart';
import 'package:pokedex/src/pages/home/widgets/poke_item.dart';
import 'package:pokedex/src/routes/app_route_generator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());

    void viewPokemon(int index) {
      Get.put(PokeDetailsController())
        ..index = index
        ..changeSlidingSheet(0)
        ..tabController.animateTo(0);
      Get.toNamed<dynamic>(AppRoutes.pokeDetails);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -240 / 4.7,
              left: screenWidth - 240 / 1.7,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  AppConstants.imagePokeballDark,
                  width: 240,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: statusBarHeight,
                ),
                const AppBarHome(),
                Expanded(
                  child: Obx(
                    () {
                      final List<Pokemon> pokeList =
                          pokeHomeController.pokeList;

                      return pokeHomeController.isLoading.value
                          ? const Center(child: PokeLoading())
                          : AnimationLimiter(
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.all(12),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: screenWidth /
                                      (MediaQuery.of(context).size.height / 2),
                                ),
                                itemCount: pokeList.length,
                                itemBuilder: (_, index) {
                                  final Pokemon pokemon =
                                      pokeHomeController.pokeList[index];

                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: PokeItem(
                                          name: pokemon.name,
                                          index: index,
                                          image: pokemon.img,
                                          types: pokemon.type.en,
                                        ),
                                        onTap: () => viewPokemon(index),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
