import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final dynamic recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name'] ?? 'Szczegóły przepisu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe['name'] ?? 'Brak nazwy',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(recipe['description'] ?? 'Brak opisu'),
          ],
        ),
      ),
    );
  }
}
