import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  RecipeCard({required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Image.network(recipe.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(recipe.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(recipe.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: onTap,
      ),
    );
  }
}
