import 'package:flutter/material.dart';
import 'package:znajdz_przepis/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name), // Poprawione: Użycie pola `name`
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wyświetlanie nazwy przepisu
            Text(
              recipe.name, // Poprawione: Użycie pola `name`
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Wyświetlanie zdjęcia przepisu
            if (recipe.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  recipe.imageUrl, // Poprawione: Użycie pola `imageUrl`
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),

            // Wyświetlanie opisu
            Text(
              recipe.description, // Poprawione: Użycie pola `description`
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Wyświetlanie składników
            if (recipe.ingredients.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ingredients:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...recipe.ingredients.map(
                        (ingredient) => Text('- $ingredient'),
                  ),
                ],
              ),
            const SizedBox(height: 20),

            // Wyświetlanie instrukcji przygotowania
            if (recipe.instructions.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(recipe.instructions), // Poprawione: Użycie pola `instructions`
                ],
              ),
          ],
        ),
      ),
    );
  }
}
