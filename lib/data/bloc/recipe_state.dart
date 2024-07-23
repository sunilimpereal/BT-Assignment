part of 'recipe_bloc.dart';

@immutable
abstract class RecipeState {}

class RecipeInitialState extends RecipeState {}

class RecipeLoadingState extends RecipeState {}

class RecipeLoadedState extends RecipeState {
  final List<Recipe> recipes;

  RecipeLoadedState(this.recipes);
}

class RecipeErrorState extends RecipeState {
  final String message;

  RecipeErrorState(this.message);
}
