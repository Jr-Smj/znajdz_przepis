class Recipe {
  final String name;
  final String description;
  final String imageUrl;

  Recipe({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? 'Unknown Title',
      description: json['description'] ?? 'No description available',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
