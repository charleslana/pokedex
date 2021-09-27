import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

class EvolutionPokeDetails extends StatelessWidget {
  const EvolutionPokeDetails({Key? key}) : super(key: key);

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
          children: getEvolution(pokemon),
        ),
      );
    });
  }

  List<Widget> getEvolution(Pokemon pokemon) {
    final List<Widget> list = [];

    if (pokemon.preEvolution.isNotEmpty) {
      for (final evolution in pokemon.preEvolution) {
        list
          ..add(
            SizedBox(
              width: 80,
              height: 80,
              child: CachedNetworkImage(
                placeholder: (_, __) => const Center(
                  child: PokeLoading(),
                ),
                imageUrl: evolution.img,
              ),
            ),
          )
          ..add(
            SizedBox(
              height: 20,
              child: Text(
                evolution.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          ..add(
            const SizedBox(
              height: 40,
              child: Icon(Icons.keyboard_arrow_down),
            ),
          );
      }
    }
    if (pokemon.nextEvolution.isNotEmpty) {
      for (final evolution in pokemon.nextEvolution) {
        list
          ..add(
            SizedBox(
              width: 80,
              height: 80,
              child: CachedNetworkImage(
                placeholder: (_, __) => const Center(
                  child: PokeLoading(),
                ),
                imageUrl: evolution.img,
              ),
            ),
          )
          ..add(
            SizedBox(
              height: 20,
              child: Text(
                evolution.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        if (pokemon.nextEvolution.last.name != evolution.name) {
          list.add(
            const SizedBox(
              height: 40,
              child: Icon(Icons.keyboard_arrow_down),
            ),
          );
        }
      }

      if (pokemon.nextEvolution.isEmpty) {
        list.removeLast();
      }
    } else {
      list.add(const Center(child: Text('No evolution found')));
    }

    return list;
  }
}
