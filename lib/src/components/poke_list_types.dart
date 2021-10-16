import 'package:flutter/material.dart';
import 'package:pokedex/src/constants/app_constants.dart';

class PokeListTypes extends StatelessWidget {
  const PokeListTypes({
    required this.types,
    Key? key,
  }) : super(key: key);

  final List<String> types;

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidgets = [];

    for (final name in types) {
      listWidgets.add(
        Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(80, 255, 255, 255)),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Image.asset(
                        AppConstants().getImageType(name),
                        width: 20,
                      ),
                      Text(
                        name.trim(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
