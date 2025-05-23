import 'package:flutter/material.dart';
import 'package:znajdz_przepis/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            if (recipe.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  recipe.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            Text(
              recipe.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

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

            if (recipe.instructions.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(recipe.instructions),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
