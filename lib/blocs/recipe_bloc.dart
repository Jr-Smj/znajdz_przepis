import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znajdz_przepis/blocs/recipe_event.dart';
import 'package:znajdz_przepis/blocs/recipe_state.dart';
import 'package:znajdz_przepis/repositories/recipe_repository.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository recipeRepository;

  RecipeBloc({required this.recipeRepository}) : super(RecipeInitial()) {
    on<FetchRecipes>((event, emit) async {
      emit(RecipeLoading());
      try {
        final recipes = await recipeRepository.fetchRecipes(event.query);
        emit(RecipeLoaded(recipes: recipes));
      } catch (e) {
        emit(RecipeError(message: e.toString()));
      }
    });
  }
}
