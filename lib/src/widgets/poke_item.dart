import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/src/constants/constants_app.dart';
import 'package:pokedex/src/widgets/poke_loading.dart';

class PokeItem extends StatelessWidget {
  const PokeItem({
    required this.name,
    required this.index,
    required this.image,
    required this.types,
    Key? key,
  }) : super(key: key);

  final String name;
  final int index;
  final String image;
  final List<String> types;

  Widget listTypes() {
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

  Widget getImage(String image) {
    return CachedNetworkImage(
      width: 100,
      height: 100,
      placeholder: (_, url) => const Center(
        child: PokeLoading(),
      ),
      imageUrl: ConstantsApp().getPokeImage(image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: ConstantsApp.getColorType(types[0]),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    ConstantsApp.imagePokeballWhite,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: getImage(image),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 35,
                  left: 8,
                ),
                child: listTypes(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}