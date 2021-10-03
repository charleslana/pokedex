import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pokedex/src/components/poke_loading.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/models/poke_model.dart';

class PokeItem extends StatelessWidget {
  const PokeItem({
    required this.name,
    required this.index,
    required this.image,
    required this.num,
    required this.pokeType,
    Key? key,
  }) : super(key: key);

  final String name;
  final int index;
  final String image;
  final String num;
  final PokeType pokeType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants().getColorType(pokeType.en[0])!,
              if (pokeType.en.length > 1)
                AppConstants().getColorType(pokeType.en[1])!
              else
                AppConstants().getColorType(pokeType.en[0])!,
            ],
            stops: const [0, 1],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.topLeft,
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        num,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _listTypes(),
                    Expanded(
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              AppConstants.imagePokeballWhite,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Hero(
                            tag: name,
                            child: CachedNetworkImage(
                              width: 100,
                              height: 100,
                              placeholder: (_, __) => const Center(
                                child: PokeLoading(),
                              ),
                              imageUrl: image,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTypes() {
    final List<Widget> listWidgets = [];
    List<String> types = pokeType.ptBr;

    if ('languageCode'.tr == 'en') {
      types = pokeType.en;
    }

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
                child: FittedBox(
                  fit: BoxFit.fitWidth,
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
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      );
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listWidgets,
      ),
    );
  }
}
