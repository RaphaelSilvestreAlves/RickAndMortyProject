import 'package:flutter/material.dart';
import 'package:projeto_rick_and_morty/app/models/character_model.dart';

class SearchController {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<List<CharacterModel>> filteredCharacters = ValueNotifier<List<CharacterModel>>([]);
  List<CharacterModel> allCharacters = [];

  // Método para setar os personagens iniciais
  void setCharacters(List<CharacterModel> characters) {
    allCharacters = characters;
    filteredCharacters.value = characters; // Inicia com todos os personagens
  }

  // Filtra os personagens conforme o texto da pesquisa
  void filterCharacters(String query) {
    if (query.isEmpty) {
      filteredCharacters.value = allCharacters; // Retorna todos se o campo de pesquisa estiver vazio
    } else {
      filteredCharacters.value = allCharacters.where((character) {
        return character.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  // Adiciona um listener para mudanças no campo de pesquisa
  void addSearchListener() {
    searchController.addListener(() {
      filterCharacters(searchController.text); // Filtra os personagens conforme o texto
    });
  }
}




