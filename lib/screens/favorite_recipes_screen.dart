import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import 'recipe_detail_screen.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  _FavoriteRecipesScreenState createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  List<Recipe> recipes = [];
  String? errorMessage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final Box favoritesBox = Hive.box('favoritesBox');
      final loadedRecipes = favoritesBox.values
          .map((json) => Recipe.fromJson(Map<String, dynamic>.from(json)))
          .toList();

      setState(() {
        recipes = loadedRecipes;
        errorMessage = null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred while loading your favorite recipes: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Favorite recipe')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Favorite recipe')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(errorMessage!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loadFavorites,
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite recipe'),
      ),
      body: recipes.isEmpty
          ? const Center(child: Text('No favorite recipes'))
          : ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: recipe.imageUrl.isNotEmpty
                  ? Image.network(recipe.imageUrl, width: 60, height: 60, fit: BoxFit.cover)
                  : const Icon(Icons.fastfood),
              title: Text(recipe.name),
              subtitle: Text(recipe.description, maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
