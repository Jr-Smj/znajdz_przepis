class Recipe {
  final String title;
  final String imageUrl;
  final List<String> ingredients;

  Recipe({required this.title, required this.imageUrl, required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      imageUrl: json['image'],
      ingredients: List<String>.from(json['extendedIngredients']
          .map((ingredient) => ingredient['original'])),
    );
  }
}
