import 'package:flutter/material.dart';
import 'package:projeto_rick_and_morty/app/models/character_model.dart';

class SearchController {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<List<CharacterModel>> filteredCharacters = ValueNotifier<List<CharacterModel>>([]);
  List<CharacterModel> allCharacters = [];

  void setCharacters(List<CharacterModel> characters) {
    allCharacters = characters;
    filteredCharacters.value = characters;
  }

  void filterCharacters(String query) {
    if (query.isEmpty) {
      filteredCharacters.value = allCharacters;
    } else {
      filteredCharacters.value = allCharacters.where((character) {
        return character.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void addSearchListener() {
    searchController.addListener(() {
      filterCharacters(searchController.text);
    });
  }
}




