import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/src/constants/constants_app.dart';
import 'package:pokedex/src/models/poke_api.dart';

class PokeApiService {
  Future<dynamic> getPokeApi() async {
    try {
      final response = await http.get(Uri.parse(ConstantsApp.baseURL));
      if (response.statusCode == 200) {
        final dynamic decodeJson = jsonDecode(response.body);
        return PokeApi.fromJson(decodeJson);
      }
      return null;
    } on Exception {
      return null;
    }
  }
}
