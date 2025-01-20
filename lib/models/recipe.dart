class Recipe {
  final String title;
  final String imageUrl;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? 'No title available',
      imageUrl: json['image'] ?? '',
      ingredients: json['extendedIngredients'] != null
          ? List<String>.from(json['extendedIngredients']
          .map((ingredient) => ingredient['original'] ?? 'Unknown ingredient'))
          : [],
    );
  }
}
