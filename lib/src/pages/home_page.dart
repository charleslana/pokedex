import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/src/constants/constants_app.dart';
import 'package:pokedex/src/models/poke_api.dart';
import 'package:pokedex/src/stores/poke_api_store.dart';
import 'package:pokedex/src/widgets/poke_item.dart';
import 'package:pokedex/src/widgets/poke_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PokeApiStore pokeApiStore;

  Future<void> init() async {
    pokeApiStore = PokeApiStore();
    await pokeApiStore.fetchPokemonList();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

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
                ConstantsApp.imagePokeballDark,
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
                child: Observer(
                  builder: (_) {
                    final PokeApi? pokeApi = pokeApiStore.pokeApi;

                    return pokeApi == null
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
                              itemCount: pokeApi.pokemon.length,
                              itemBuilder: (_, index) {
                                final Pokemon pokemon =
                                    pokeApiStore.getPokemon(index);

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
                                      onTap: () {},
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
              'Pokedex',
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
