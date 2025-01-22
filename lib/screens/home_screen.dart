import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/recipe_bloc.dart';
import '../screens/recipe_detail_screen.dart';
import '../blocs/recipe_event.dart';
import '../blocs/recipe_state.dart';
import '../repositories/recipe_repository.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find the Recipe'),
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

  RecipeSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A7CA5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<RecipeBloc>(context).add(FetchRecipes(_controller.text));
                },
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<RecipeBloc, RecipeState>(
            builder: (context, state) {
              if (state is RecipeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RecipeLoaded) {
                if (state.recipes.isEmpty) {
                  return const Center(child: Text('No recipes to display.'));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = state.recipes[index];
                      return RecipeCard(recipe: recipe);
                    },
                  ),
                );
              } else if (state is RecipeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              // Default state: Display the logo
              return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset(
                    'assets/images/Logo.png',
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
