class Wand {
  final String wood;
  final String core;
  final num length;

  Wand({required this.wood, required this.core, required this.length});

  factory Wand.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Wand(wood: '', core: '', length: 0);
    return Wand(
      wood: json['wood'] as String? ?? '',
      core: json['core'] as String? ?? '',
      length: json['length'] as num? ?? 0,
    );
  }
}

class Character {
  final String id;
  final String name;
  final List<String> alternateNames;
  final String species;
  final String gender;
  final String house;
  final String dateOfBirth;
  final int yearOfBirth;
  final bool wizard;
  final String ancestry;
  final String eyeColour;
  final String hairColour;
  final Wand wand;
  final String patronus;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final String actor;
  final List<String> alternateActors;
  final bool alive;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      alternateNames: (json['alternate_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      species: json['species'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      house: json['house'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] as String? ?? '',
      yearOfBirth: json['yearOfBirth'] as int? ?? 0,
      wizard: json['wizard'] as bool? ?? false,
      ancestry: json['ancestry'] as String? ?? '',
      eyeColour: json['eyeColour'] as String? ?? '',
      hairColour: json['hairColour'] as String? ?? '',
      wand: Wand.fromJson(json['wand'] as Map<String, dynamic>?),
      patronus: json['patronus'] as String? ?? '',
      hogwartsStudent: json['hogwartsStudent'] as bool? ?? false,
      hogwartsStaff: json['hogwartsStaff'] as bool? ?? false,
      actor: json['actor'] as String? ?? '',
      alternateActors: (json['alternate_actors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      alive: json['alive'] as bool? ?? false,
      image: json['image'] as String? ?? '',
    );
  }
}
