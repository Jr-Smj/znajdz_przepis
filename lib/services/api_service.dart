import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const _baseUrl = 'https://tasty.p.rapidapi.com/recipes/list';
  static const _headers = {
    'x-rapidapi-key': '2c84052aacmshd4f2217e5856736p1d6883jsn90f6e460f1fc',
    'x-rapidapi-host': 'tasty.p.rapidapi.com',
  };

  static Future<List<Recipe>> fetchRecipes(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?from=0&size=20&q=$query'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List recipes = data['results'];
      return recipes.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
