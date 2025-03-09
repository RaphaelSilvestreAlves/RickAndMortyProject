import 'dart:convert';

import 'package:projeto_rick_and_morty/app/data/http/exceptions.dart';
import 'package:projeto_rick_and_morty/app/data/http/httpClient.dart';
import 'package:projeto_rick_and_morty/app/models/character_model.dart';

abstract class ICharacterRepository {
  Future<List<CharacterModel>> getCharacters();
}

class CharacterRepository implements ICharacterRepository{

  final IHttpClient client;

  CharacterRepository({required this.client});

   @override
  Future<List<CharacterModel>> getCharacters({String? url}) async {
    final response = await client.get(
      url: url ?? 'https://rickandmortyapi.com/api/character',
    );

    if (response.statusCode == 200) {
      final List<CharacterModel> characters = [];
      final body = jsonDecode(response.body);

      body['results'].map((item) {
        final CharacterModel character = CharacterModel.fromMap(item);
        characters.add(character);
      }).toList();

      return characters;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar os Personagens');
    }
  }
}