import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_card.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/routes/app_route_generator.dart';

class PokeGridView extends StatelessWidget {
  const PokeGridView({
    required this.pokeList,
    Key? key,
  }) : super(key: key);

  final List<Pokemon> pokeList;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      key: key,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
        ),
        itemCount: pokeList.length,
        itemBuilder: (_, index) {
          final Pokemon pokemon = pokeList[index];

          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: ScaleAnimation(
              child: GestureDetector(
                child: PokeCard(
                  name: pokemon.name,
                  index: index,
                  image: pokemon.img,
                  num: pokemon.num,
                  pokeType: pokemon.type,
                ),
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.toNamed<dynamic>(
                    AppRoutes.pokeDetails,
                    arguments: pokemon.id - 1,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
