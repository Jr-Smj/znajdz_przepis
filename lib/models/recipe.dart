class Recipe {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? 'Unknown Title',
      description: json['description'] ?? 'No description available',
      imageUrl: json['thumbnail_url'] ?? '',
      ingredients: (json['sections']?[0]['components'] as List<dynamic>?)
          ?.map((item) => item['raw_text'] as String)
          .toList() ??
          [],
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((item) => item['display_text'])
          .join('\n') ??
          'No instructions available',
    );
  }
}
