import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/constants/constants_app.dart';
import 'package:pokedex/src/controllers/poke_details_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_api.dart';
import 'package:pokedex/src/widgets/poke_loading.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailsPage extends StatefulWidget {
  const PokeDetailsPage({Key? key}) : super(key: key);

  @override
  State<PokeDetailsPage> createState() => _PokeDetailsPageState();
}

class _PokeDetailsPageState extends State<PokeDetailsPage> {
  PageController _controller = PageController();
  final PokeDetailsController _pokeDetailsController =
      Get.put(PokeDetailsController());
  final PokeHomeController _pokeHomeController = Get.put(PokeHomeController());

  @override
  void initState() {
    _controller = PageController(initialPage: _pokeDetailsController.index);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Obx(() {
      final Pokemon pokemon =
          _pokeHomeController.pokeList[_pokeDetailsController.index];

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ConstantsApp().getColorType(pokemon.type[0]),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
          ],
        ),
        backgroundColor: ConstantsApp().getColorType(pokemon.type[0]),
        body: Stack(
          children: [
            Container(
              height: height / 3,
            ),
            SlidingSheet(
              cornerRadius: 16,
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
                controller: _controller,
                onPageChanged: (int index) =>
                    _pokeDetailsController.index = index,
                physics: const BouncingScrollPhysics(),
                itemCount: _pokeHomeController.pokeList.length,
                itemBuilder: (_, int index) {
                  return CachedNetworkImage(
                    placeholder: (_, url) => const Center(
                      child: PokeLoading(),
                    ),
                    imageUrl: _pokeHomeController.pokeList[index].img,
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
