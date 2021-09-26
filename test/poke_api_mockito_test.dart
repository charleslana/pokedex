import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/poke_api_service.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  final client = ClientMock();
  final pokeApiSerive = PokeApiService(client);
  test('Get pokemon list with mock', () async {
    when(() => client.get(Uri.parse(AppConstants.baseURL)))
        .thenAnswer((_) async => http.Response(jsonReturn, 200));

    final PokeModel pokeModel = await pokeApiSerive.getPokeApi();
    expect(pokeModel.pokemon.isNotEmpty, equals(true));
  });

  test('Throws an exception if the http call completes with an error',
      () async {
    when(() => client.get(Uri.parse(AppConstants.baseURL)))
        .thenAnswer((_) async => http.Response('Not found', 404));

    expect(pokeApiSerive.getPokeApi, throwsException);
  });
}

const jsonReturn = '''
    {"pokemon":[{"id":1,"num":"01","name":"Bulbasaur","img":"https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/images/001.png","type":{"en":["Grass","Poison"],"pt_br":["Planta","Veneno"]},"atk":118,"sta":128,"def":111,"generation":1,"description":{"en":"Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.","pt_br":"Bulbasaur pode ser visto cochilando sob a luz do sol. Há uma semente nas costas. Ao absorver os raios do sol, a semente cresce progressivamente maior."},"weight":6.9,"height":0.7,"pre_evolution":[],"next_evolution":[{"id":2,"num":"02","name":"Ivysaur","img":"https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/images/002.png"},{"id":3,"num":"03","name":"Venusaur","img":"https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/images/003.png"}],"max_cp":1260,"resistant":{"en":["Electric","Fairy","Fighting","Grass","Psychic","Water"],"pt_br":["Elétrico","Fada","Lutador","Planta","Psíquico","Água"]},"weaknesses":{"en":["Fire","Flying","Ice"],"pt_br":["Fogo","Voador","Gelo"]},"moves":{"en":["Vine Whip","Power Whip","Sludge Bomb"],"pt_br":["Chicote de Videira","Chicote de Poder","Bomba de Lodo"]}},{"id":2,"num":"02","name":"Ivysaur","img":"https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/images/002.png","type":{"en":["Grass","Poison"],"pt_br":["Planta","Veneno"]},"atk":151,"sta":155,"def":143,"generation":1,"description":{"en":"There is a bud on this Pokémon's back. To support its weight, Ivysaur's legs and trunk grow thick and strong. If it starts spending more time lying in the sunlight, it's a sign that the bud will bloom into a large flower soon.","pt_br":"Há um botão nas costas deste Pokémon. Para suportar seu peso, as pernas e o tronco de Ivysaur ficam grossos e fortes. Se ele começar a ficar mais tempo deitado ao sol, é um sinal de que o botão florescerá em uma grande flor em breve."},"weight":13.0,"height":1.0,"pre_evolution":[{"id":1,"num":"01","name":"Bulbasaur","img":"https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/images/001.png"}],"next_evolution":[{"id":3,"num":"03","name":"Venusaur","img":"https://raw.githubusercontent.com/charleslana/pokemon-go-pokedex-api/main/images/003.png"}],"max_cp":1921,"resistant":{"en":["Electric","Fairy","Fighting","Grass","Water"],"pt_br":["Elétrico","Fada","Lutador","Planta","Água"]},"weaknesses":{"en":["Fire","Flying","Ice","Psychic"],"pt_br":["Fogo","Voador","Gelo","Psíquico"]},"moves":{"en":["Vine Whip","Power Whip","Sludge Bomb"],"pt_br":["Chicote de Videira","Chicote de Poder","Bomba de Lodo"]}}]}
    ''';
