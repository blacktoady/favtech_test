class Person {
  final String name;
  final String profilePath;
  final double popularity;

  Person({required this.name, required this.profilePath, required this.popularity});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      profilePath: json['profile_path'],
      popularity: json['popularity'],
    );
  }
}
