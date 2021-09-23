import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_api.dart';
import 'package:pokedex/src/routes/app_routes.dart';
import 'package:pokedex/src/widgets/poke_item.dart';
import 'package:pokedex/src/widgets/poke_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
    final PokeDetailsController pokeDetailsController =
        Get.put(PokeDetailsController());

    void viewPokemon(int index, List<Pokemon> pokeList) {
      pokeDetailsController.index = index;
      Get.toNamed<dynamic>(AppRoutes.pokeDetails);
    }

    return Scaffold(
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
              _appBarHome(screenWidth, statusBarHeight),
              Expanded(
                child: Obx(
                  () {
                    final List<Pokemon> pokeList = pokeHomeController.pokeList;

                    return pokeList.isEmpty
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
                                        types: pokemon.type,
                                      ),
                                      onTap: () => viewPokemon(index, pokeList),
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
    );
  }

  Widget _appBarHome(double screenWidth, double statusBarHeight) {
    return Container(
      height: 150,
      color: const Color.fromARGB(200, 240, 245, 210).withOpacity(0),
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
                  top: 150 / 3.1 - statusBarHeight,
                  left: screenWidth - 175,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      onPressed: () {},
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
    );
  }
}
