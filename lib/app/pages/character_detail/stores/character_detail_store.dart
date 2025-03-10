import 'package:flutter/material.dart';
import 'package:projeto_rick_and_morty/app/models/character_detail_model.dart';
import 'package:projeto_rick_and_morty/app/repositories/character_detail_repository.dart';

class CharacterDetailStore {
  final ICharacterDetailRepository repository;

  ValueNotifier<CharacterDetailModel?> characterDetail = ValueNotifier(null);
  ValueNotifier<String?> error = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  CharacterDetailStore({required this.repository});

  Future<void> loadCharacterDetail(int id) async {
    try {
      isLoading.value = true;
      final CharacterDetailModel detail = await repository.getCharacterDetail(id);
      characterDetail.value = detail;
    } catch (e) {
      error.value = 'Erro ao carregar os detalhes do personagem: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
