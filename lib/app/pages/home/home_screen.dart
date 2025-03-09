import 'package:flutter/material.dart' hide SearchController;
import 'package:projeto_rick_and_morty/app/controllers/search_controller.dart';
import 'package:projeto_rick_and_morty/app/core/app_colors.dart';
import 'package:projeto_rick_and_morty/app/data/http/httpClient.dart';
import 'package:projeto_rick_and_morty/app/models/character_model.dart';
import 'package:projeto_rick_and_morty/app/pages/character_detail/character_detail_screen.dart';
import 'package:projeto_rick_and_morty/app/pages/home/stores/character_store.dart';
import 'package:projeto_rick_and_morty/app/repositories/character_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CharacterStore characterStore;
  late SearchController searchController;

  @override
  void initState() {
    super.initState();

    final repository = CharacterRepository(client: Httpclient());
    characterStore = CharacterStore(repository: repository);
    searchController = SearchController();

    characterStore.loadCharacters().then((_) {
      searchController.setCharacters(characterStore.characters.value);

      searchController.addSearchListener();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rickWhite,
      appBar: AppBar(
        backgroundColor: AppColors.rickGreen,
        centerTitle: true,
        title: const Text(
          'Rick And Morty',
          style: TextStyle(
            fontFamily: 'RickAndMorty',
            color: AppColors.rickBlue,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: characterStore.isSearchEnabled,
              builder: (context, isSearchEnabled, child) {
                return isSearchEnabled
                    ? TextField(
                      controller: searchController.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a character...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                      ),
                    )
                    : Container();
              },
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: characterStore.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<String?>(
            valueListenable: characterStore.error,
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

              return ValueListenableBuilder<List<CharacterModel>>(
                valueListenable: searchController.filteredCharacters,
                builder: (context, characters, child) {
                  if (characters.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhum personagem encontrado',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: characters.length,
                    itemBuilder: (_, index) {
                      final item = characters[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CharacterDetailScreen(
                                    characterId: item.id,
                                  ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    item.image,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 32),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color:
                                                  item.status == "Alive"
                                                      ? Colors.green
                                                      : item.status == "Dead"
                                                      ? Colors.red
                                                      : Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "${item.status} | ${item.species}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Last known location: ${item.location}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
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
