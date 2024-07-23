part of 'recipe_bloc.dart';

@immutable
abstract class RecipeEvent {}

class GetRecipeEvent extends RecipeEvent {}

class AddRecipeEvent extends RecipeEvent {
  final Recipe recipe;

  AddRecipeEvent(this.recipe);
}

class EditRecipeEvent extends RecipeEvent {
  final Recipe recipe;

  EditRecipeEvent(this.recipe);
}

class DeleteRecipeEvent extends RecipeEvent {
  final int recipeId;

  DeleteRecipeEvent(this.recipeId);
}

class DeleteAllRecipesEvent extends RecipeEvent {}

class SearchRecipeEvent extends RecipeEvent {
  final String query;

  SearchRecipeEvent(this.query);
}

class FilterRecipeEvent extends RecipeEvent {
  final String category;

  FilterRecipeEvent(this.category);
}