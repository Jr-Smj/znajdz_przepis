import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/recipe_bloc.dart';
import '../screens/recipe_detail_screen.dart';
import '../blocs/recipe_event.dart';
import '../blocs/recipe_state.dart';
import '../repositories/recipe_repository.dart'; // Upewnij się, że zaimportujesz odpowiedni plik

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Znajdź Przepis'),
        backgroundColor: const Color(0xFF16425B),
      ),
      body: BlocProvider(
        create: (_) => RecipeBloc(recipeRepository: RecipeRepository()),
        child: RecipeSearch(),
      ),
    );
  }
}

class RecipeSearch extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Szukaj przepisu',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3A7CA5)),
          onPressed: () {
            BlocProvider.of<RecipeBloc>(context).add(FetchRecipes(_controller.text));
          },
          child: const Text('Szukaj'),
        ),
        Expanded(
          child: BlocBuilder<RecipeBloc, RecipeState>(
            builder: (context, state) {
              if (state is RecipeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RecipeLoaded) {
                if (state.recipes.isEmpty) {
                  return const Center(child: Text('Brak przepisów do wyświetlenia.'));
                }
                return ListView.builder(
                  itemCount: state.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = state.recipes[index];
                    final recipeName = recipe.name ?? 'Brak nazwy';
                    return ListTile(
                      title: Text(recipeName),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is RecipeError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Wyszukaj przepis.'));
            },
          ),
        ),
      ],
    );
  }
}
