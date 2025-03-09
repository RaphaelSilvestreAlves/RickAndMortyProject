import 'package:flutter/material.dart';
import 'package:projeto_rick_and_morty/app/core/app_colors.dart';
import 'package:projeto_rick_and_morty/app/models/character_detail_model.dart';
import 'package:projeto_rick_and_morty/app/pages/character_detail/stores/character_detail_store.dart';
import 'package:projeto_rick_and_morty/app/repositories/character_detail_repository.dart';
import 'package:projeto_rick_and_morty/app/data/http/httpClient.dart';

class CharacterDetailScreen extends StatefulWidget {
  final int characterId;

  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late CharacterDetailStore store;

  @override
  void initState() {
    super.initState();

    final repository = CharacterDetailRepository(client: Httpclient());
    store = CharacterDetailStore(repository: repository);

    store.loadCharacterDetail(widget.characterId);
  }

  final TextStyle contentTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rickWhite,
      appBar: AppBar(
        backgroundColor: AppColors.rickGreen,
        centerTitle: true,
        title: const Text(
          "CHARACTER DETAIL",
          style: TextStyle(
            fontFamily: 'RickAndMorty',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: AppColors.rickBlue,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: store.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<String?>(
            valueListenable: store.error,
            builder: (context, error, child) {
              if (error != null) {
                return Center(
                  child: Text(
                    error,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                );
              }

              return ValueListenableBuilder<CharacterDetailModel?>(
                valueListenable: store.characterDetail,
                builder: (context, character, child) {
                  if (character == null) {
                    return const Center(
                      child: Text(
                        'Personagem não encontrado',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            character.image,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          character.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'RickAndMorty',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color:
                                        character.status == "Alive"
                                            ? Colors.green
                                            : character.status == "Dead"
                                            ? Colors.red
                                            : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Status: ${character.status}",
                                  style: contentTextStyle,
                                ),
                              ],
                            ),
                            Text(
                              "Species: ${character.species}",
                              style: contentTextStyle,
                            ),
                            Text(
                              "Type: ${character.type.isNotEmpty == true ? character.type : 'Irrelevant'}",
                              style: contentTextStyle,
                            ),
                            Text(
                              "Gender: ${character.gender}",
                              style: contentTextStyle,
                            ),
                            Text(
                              "Origin: ${character.origin}",
                              style: contentTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Last known location: ${character.location}",
                              style: contentTextStyle,
                            ),
                            Text(
                              "Created at: ${character.createdAt}",
                              style: contentTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
