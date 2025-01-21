import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRecipes extends RecipeEvent {
  final String query;

  FetchRecipes(this.query);

  @override
  List<Object?> get props => [query];
}
