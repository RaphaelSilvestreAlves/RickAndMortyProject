class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String origin;
  final String location;
  final String image;

  CharacterModel({
  required this.id,
  required this.name,
  required this.status,
  required this.species,
  required this.gender,
  required this.origin,
  required this.location,
  required this.image,

  });

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      gender: map['gender'],
      origin: map['location']['name'],
      location: map['location']['name'],
      image: map['image'],
    );
  }
}