import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _recipes = [];

  Future<void> _searchRecipes(String query) async {
    try {
      final recipes = await ApiService.searchRecipes(query);
      setState(() {
        _recipes = recipes;
      });
    } catch (e) {
      print('Błąd w _searchRecipes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nie udało się załadować przepisów. Spróbuj ponownie.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Znajdź Przepis'),
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              _searchRecipes(value);
            },
            decoration: InputDecoration(
              labelText: 'Wyszukaj przepis',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return ListTile(
                  title: Text(recipe.title),
                  subtitle: Text('Składniki: ${recipe.ingredients.join(", ")}'),
                  leading: recipe.imageUrl.isNotEmpty
                      ? Image.network(recipe.imageUrl, width: 50, height: 50)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
