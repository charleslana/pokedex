import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/models/poke_api.dart';

class PokeApiService {
  PokeApiService(this.client);

  Client client;

  Future<PokeApi> getPokeApi() async {
    try {
      final response = await client.get(Uri.parse(AppConstants.baseURL));
      if (response.statusCode == 200) {
        final dynamic decodeJson = jsonDecode(response.body);
        return PokeApi.fromJson(decodeJson);
      }
      throw Exception('API error');
    } on Exception catch (error) {
      throw Exception('Internet error: $error');
    }
  }
}
