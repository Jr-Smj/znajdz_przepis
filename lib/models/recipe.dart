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
    if (json['ingredients'] is List) {
      parsedIngredients = List<String>.from(json['ingredients']);
    } else if (json['sections'] is List) {
      parsedIngredients = (json['sections'][0]['components'] as List)
          .map((item) => item['raw_text'] as String)
          .toList();
    } else if (json['ingredients'] is String) {
      parsedIngredients = (json['ingredients'] as String).split('\n');
    }

    String parsedInstructions;
    if (json['instructions'] is List) {
      parsedInstructions = (json['instructions'] as List)
          .map((item) => item['display_text'])
          .join('\n');
    } else if (json['instructions'] is String) {
      parsedInstructions = json['instructions'];
    } else {
      parsedInstructions = 'No instructions available';
    }

    return Recipe(
      name: json['name'] ?? 'Unknown Title',
      description: json['description'] ?? 'No description available',
      imageUrl: json['thumbnail_url'] ?? json['imageUrl'] ?? '',
      ingredients: parsedIngredients,
      instructions: parsedInstructions,
      isFavorite: json['isFavorite'] ?? false,
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

