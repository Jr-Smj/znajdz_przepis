import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart'; // Import modelu Recipe

class RecipeRepository {
  final String apiUrl = 'https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes';

  Future<List<Recipe>> fetchRecipes(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl&q=$query'),
      headers: {
        'x-rapidapi-host': 'tasty.p.rapidapi.com',
        'x-rapidapi-key': 'ca8319f3e0mshe8bbbdd65b5de49p13b27bjsnfe99cdc08f4a',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'] != null) {
        return (data['results'] as List<dynamic>)
            .map((json) => Recipe.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }
}
