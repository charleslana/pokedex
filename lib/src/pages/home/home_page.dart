import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_grid_view.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/controllers/theme_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/pages/home/widgets/app_bar_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
    final ThemeController themeController = Get.put(ThemeController());

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: statusBarHeight - 240 / 4.7,
                right: -80,
                child: Opacity(
                  opacity: 0.1,
                  child: Obx(() {
                    return Image.asset(
                      themeController.isDarkMode.value
                          ? AppConstants.imagePokeballWhite
                          : AppConstants.imagePokeballDark,
                      width: 240,
                    );
                  }),
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
                            pokeHomeController.filterPokeList;

                        return pokeHomeController.isLoading.value
                            ? const Center(child: PokeLoading())
                            : pokeList.isEmpty
                                ? Center(
                                    child:
                                        Text('pokeHomeSearchNoPokemonFound'.tr))
                                : PokeGridView(
                                    pokeList: pokeList,
                                    key: ValueKey(
                                        pokeHomeController.counter.value),
                                  );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
