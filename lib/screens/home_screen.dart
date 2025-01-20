import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> recipes;

  @override
  void initState() {
    super.initState();
    recipes = ApiService.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Znajdź Przepis'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nie znaleziono przepisów'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return RecipeCard(
                  recipe: recipe,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
