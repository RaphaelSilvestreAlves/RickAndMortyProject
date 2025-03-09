class CharacterDetailModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String type;
  final String origin;
  final String location;
  final String image;
  final List<String> episodes;
  final String createdAt;

  CharacterDetailModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.type,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
    required this.createdAt,
  });

  factory CharacterDetailModel.fromMap(Map<String, dynamic> map) {
    return CharacterDetailModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      gender: map['gender'],
      type: map['type'],
      origin: map['origin']['name'], 
      location: map['location']['name'],
      image: map['image'],
      episodes: List<String>.from(map['episode'] ?? []),
      createdAt: map['created'],
    );
  }
}
