import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Recipe>> _recipes;

  void _searchRecipes(String query) {
    setState(() {
      _recipes = ApiService.fetchRecipes(query);
    });
  }

  @override
  void initState() {
    super.initState();
    _recipes = ApiService.fetchRecipes(""); // Wyświetla losowe przepisy początkowo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Znajdź Przepis'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Wpisz nazwę przepisu',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchRecipes(_searchController.text),
                ),
              ),
              onSubmitted: _searchRecipes,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _recipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Błąd: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Brak wyników'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final recipe = snapshot.data![index];
                      return RecipeCard(recipe: recipe);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
