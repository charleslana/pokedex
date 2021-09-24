import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_api.dart';
import 'package:pokedex/src/widgets/poke_loading.dart';
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

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppConstants().getColorType(pokemon.type[0]),
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
          ],
        ),
        backgroundColor: AppConstants().getColorType(pokemon.type[0]),
        body: Stack(
          children: [
            Container(
              height: height / 3,
            ),
            SlidingSheet(
              cornerRadius: 30,
              snapSpec: const SnapSpec(
                snappings: [0.7, 1.0],
              ),
              body: const Center(
                child: Text('This widget is below the SlidingSheet'),
              ),
              builder: (_, __) {
                return SizedBox(
                  height: height,
                  child: const Center(
                    child: Text('This is the content of the sheet'),
                  ),
                );
              },
            ),
            SizedBox(
              height: height / 3.2,
              child: PageView.builder(
                controller: pokeDetailsController.pageController.value,
                onPageChanged: (int index) =>
                    pokeDetailsController.index = index,
                physics: const BouncingScrollPhysics(),
                itemCount: pokeHomeController.pokeList.length,
                itemBuilder: (_, int index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: pokeDetailsController.animationController,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: pokeDetailsController
                                    .animationController.value *
                                2 *
                                math.pi,
                            child: child,
                          );
                        },
                        child: Hero(
                          tag: index,
                          child: Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              AppConstants.imagePokeballWhite,
                              height: height / 3.2,
                            ),
                          ),
                        ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 400),
                        padding: EdgeInsets.all(
                            pokeDetailsController.index == index ? 0 : 60),
                        curve: Curves.bounceInOut,
                        child: CachedNetworkImage(
                          placeholder: (_, url) => const Center(
                            child: PokeLoading(),
                          ),
                          color: pokeDetailsController.index == index
                              ? null
                              : Colors.black.withOpacity(0.5),
                          imageUrl: pokeHomeController.pokeList[index].img,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
