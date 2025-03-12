import 'dart:convert';
import 'package:projeto_rick_and_morty/app/data/http/http_client.dart';
import 'package:projeto_rick_and_morty/app/models/character_detail_model.dart';

abstract class ICharacterDetailRepository {
  Future<CharacterDetailModel> getCharacterDetail(int id);
}

class CharacterDetailRepository implements ICharacterDetailRepository {
  final IHttpClient client;

  CharacterDetailRepository({required this.client});

  @override
  Future<CharacterDetailModel> getCharacterDetail(int id) async {
    final response = await client.get(
      url: 'https://rickandmortyapi.com/api/character/$id',
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CharacterDetailModel.fromMap(body);
    } else {
      throw Exception('Não foi possível carregar os detalhes do personagem');
    }
  }
}
