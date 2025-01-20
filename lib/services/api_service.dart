import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String _apiKey = '2c84052aacmshd4f2217e5856736p1d6883jsn90f6e460f1fc';
  static const String _baseUrl = 'https://tasty.p.rapidapi.com';

  static Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/complexSearch?query=$query&apiKey=$_apiKey&addRecipeInformation=true'));
    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
