import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import 'recipe_detail_screen.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Box favoritesBox = Hive.box('favoritesBox');

    final recipes = favoritesBox.values
        .map((json) => Recipe.fromJson(Map<String, dynamic>.from(json)))
        .toList();

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
