import 'package:flutter/material.dart';
import 'package:projeto_rick_and_morty/app/models/character_model.dart';
import 'package:projeto_rick_and_morty/app/repositories/character_repository.dart';

class CharacterStore {
  final ICharacterRepository repository;
  
  ValueNotifier<List<CharacterModel>> characters = ValueNotifier([]);
  ValueNotifier<String?> error = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isSearchEnabled = ValueNotifier(false);

  CharacterStore({required this.repository});

  Future<void> loadCharacters() async {
    try {
      isLoading.value = true;
      final List<CharacterModel> characterList = await repository.getCharacters();
      characters.value = characterList;
      isSearchEnabled.value = true;
    } catch (e) {
      error.value = 'Erro ao carregar os personagens: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void searchCharacters(String query) {
    if (query.isEmpty) {
      isSearchEnabled.value = true;
      loadCharacters();
    } else {
      final List<CharacterModel> filteredList = characters.value
          .where((character) => character.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      characters.value = filteredList;
    }
  }
}
