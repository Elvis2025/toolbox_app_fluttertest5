class PokemonModel {
  final String name;
  final String image;
  final int baseExperience;
  final List<String> abilities;
  final String? sound;

  PokemonModel({required this.name, required this.image, required this.baseExperience, required this.abilities, this.sound});

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
    name: json['name'] ?? '',
    image: json['sprites']?['other']?['official-artwork']?['front_default'] ?? json['sprites']?['front_default'] ?? '',
    baseExperience: json['base_experience'] ?? 0,
    abilities: (json['abilities'] as List? ?? []).map((e) => e['ability']['name'].toString()).toList(),
    sound: json['cries']?['latest'],
  );
}
