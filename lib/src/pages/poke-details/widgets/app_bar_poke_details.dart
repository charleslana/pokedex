import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_animated.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

class AppBarPokeDetails extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPokeDetails({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final PokeDetailsController pokeDetailsController =
        Get.put(PokeDetailsController());
    final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
    return Obx(() {
      final Pokemon pokemon =
          pokeHomeController.pokeList[pokeDetailsController.index];

      return PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: AppConstants().getColorType(pokemon.type.en[0]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: Get.back,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Opacity(
                opacity: pokeDetailsController.opacityAppBarTitle.value,
                child: Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: pokeDetailsController.opacityAppBarTitle >= 0.3
                        ? 0.3
                        : 0.0,
                    child: const PokeAnimated(
                      image: AppConstants.imagePokeballWhite,
                      height: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        pokeDetailsController.switchFavorite(pokemon.id),
                    icon: Icon(
                      pokeDetailsController.isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
