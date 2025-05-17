class Recipe {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final String instructions;
  final bool isFavorite;

  Recipe({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> parsedIngredients = [];

    try {
      if (json['ingredients'] is List) {
        parsedIngredients = List<String>.from(json['ingredients']);
      } else if (json['sections'] is List && json['sections'].isNotEmpty) {
        var firstSection = json['sections'][0];
        if (firstSection['components'] is List) {
          parsedIngredients = (firstSection['components'] as List)
              .map((item) => item['raw_text']?.toString() ?? '')
              .where((text) => text.isNotEmpty)
              .toList();
        }
      } else if (json['ingredients'] is String) {
        parsedIngredients = (json['ingredients'] as String)
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
    } catch (e) {
      parsedIngredients = [];
    }

    String parsedInstructions = 'No instructions available';
    try {
      if (json['instructions'] is List) {
        parsedInstructions = (json['instructions'] as List)
            .map((item) => item['display_text']?.toString() ?? '')
            .where((text) => text.isNotEmpty)
            .join('\n');
        if (parsedInstructions.isEmpty) {
          parsedInstructions = 'No instructions available';
        }
      } else if (json['instructions'] is String) {
        parsedInstructions = json['instructions'];
      }
    } catch (e) {
      parsedInstructions = 'No instructions available';
    }

    return Recipe(
      name: json['name']?.toString() ?? 'Unknown Title',
      description: json['description']?.toString() ?? 'No description available',
      imageUrl: json['thumbnail_url']?.toString() ??
          json['imageUrl']?.toString() ??
          '',
      ingredients: parsedIngredients,
      instructions: parsedInstructions,
      isFavorite: json['isFavorite'] == true,
    );
  }

  Recipe copyWith({
    String? name,
    String? description,
    String? imageUrl,
    List<String>? ingredients,
    String? instructions,
    bool? isFavorite,
  }) {
    return Recipe(
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'thumbnail_url': imageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
      'isFavorite': isFavorite,
    };
  }
}
