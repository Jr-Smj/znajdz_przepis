import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String _apiKey = '2c84052aacmshd4f2217e5856736p1d6883jsn90f6e460f1fc';
  static const String _baseUrl = 'https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes';

  static Future<List<Recipe>> searchRecipes(String query) async {
    try {
      final uri = Uri.parse(
          '$_baseUrl/recipes/complexSearch?query=$query&addRecipeInformation=true');

      final headers = {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': 'tasty.p.rapidapi.com',
      };

      final response = await http.get(uri, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data == null) {
          print('Brak danych w odpowiedzi');
          throw Exception('Brak danych w odpowiedzi');
        }

        List<dynamic> results = data['results'] ?? [];
        return results.map((json) => Recipe.fromJson(json)).toList();
      } else {
        print('Błąd API: ${response.statusCode}, ${response.body}');
        throw Exception('Nie udało się załadować przepisów: ${response.statusCode}');
      }
    } catch (e) {
      print('Wystąpił wyjątek: $e');
      rethrow;
    }
  }
}
