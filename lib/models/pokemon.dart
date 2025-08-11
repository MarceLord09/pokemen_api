class Pokemon {
  final int? id;
  final String? name;
  final int? baseExperience;
  final int? height;
  final bool? isDefault;
  final PokemonSprites? sprites;

  Pokemon({
    this.isDefault,
    this.sprites,
    this.id,
    this.name,
    this.baseExperience,
    this.height,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      isDefault: json['is_default'],
      sprites: json['sprites'] != null
          ? PokemonSprites.fromJson(json['sprites'] as Map<String, dynamic>)
          : null,
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
    );
  }
}

class PokemonSprites {
  final String frontdefault;
  final String? frontshiny;

  PokemonSprites({required this.frontdefault, this.frontshiny});

  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    return PokemonSprites(
      frontdefault: json['front_default'] as String,
      frontshiny: json['front_shiny'] as String?,
    );
  }
}
