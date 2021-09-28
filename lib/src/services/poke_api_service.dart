import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pokedex/src/constants/app_constants.dart';
import 'package:pokedex/src/models/poke_model.dart';

class PokeApiService {
  PokeApiService(this.client);

  Client client;

  Future<PokeModel> getPokemon() async {
    try {
      final response = await client.get(Uri.parse(AppConstants.baseURL));
      if (response.statusCode == 200) {
        final dynamic decodeJson = jsonDecode(response.body);
        return PokeModel.fromJson(decodeJson);
      }
      await Get.defaultDialog<dynamic>(
        barrierDismissible: false,
        title: 'Error',
        middleText: 'API error',
      );
      throw Exception('API error');
    } on Exception catch (error) {
      await Get.defaultDialog<dynamic>(
        barrierDismissible: false,
        title: 'Error',
        middleText: 'Internet error: $error',
      );
      throw Exception('Internet error: $error');
    }
  }
}
