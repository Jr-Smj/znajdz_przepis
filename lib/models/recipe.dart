class Recipe {
  final String name;
  final String imageUrl;
  final String description;

  Recipe({required this.name, required this.imageUrl, required this.description});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? 'Bez nazwy',
      imageUrl: json['thumbnail_url'] ?? '',
      description: json['description'] ?? 'Brak opisu',
    );
  }
}
