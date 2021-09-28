import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/models/poke_model.dart';

class PokeApiService {
  PokeApiService(this.client);

  Client client;

  Future<PokeModel?> getPokemon() async {
    try {
      final response = await client.get(Uri.parse(AppConstants.baseURL));
      if (response.statusCode == 200) {
        final dynamic decodeJson = jsonDecode(response.body);
        return PokeModel.fromJson(decodeJson);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
