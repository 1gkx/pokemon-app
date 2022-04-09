import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemons/src/data.dart';

class PokemonRepository {
  final host = 'pokeapi.co';
  final basePath = '/api/v2/pokemon';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    final queryParams = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };
    final uri = Uri.https(host, basePath, queryParams);
    final json = await client.get(uri).then((r) => jsonDecode(r.body));
    return PokemonPageResponse.fromJson(json);
  }
}
