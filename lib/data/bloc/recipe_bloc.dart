import 'package:bloc/bloc.dart';
import 'package:bt_assignment/data/model/recipe.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final List<Recipe> _allRecipes = [];
  List<Recipe> _filteredRecipes = [];

  RecipeBloc() : super(RecipeInitialState()) {
    on<GetRecipeEvent>((event, emit) {
      emit(RecipeLoadedState(List.from(_filteredRecipes)));
    });

    on<AddRecipeEvent>((event, emit) {
      _allRecipes.add(event.recipe);
      _filteredRecipes.add(event.recipe); // Add to filtered list as well
      emit(RecipeLoadedState(List.from(_filteredRecipes)));
    });

    on<EditRecipeEvent>((event, emit) {
      final index = _allRecipes.indexWhere((recipe) => recipe.id == event.recipe.id);
      if (index != -1) {
        _allRecipes[index] = event.recipe;
        _filteredRecipes = _filteredRecipes.map((r) => r.id == event.recipe.id ? event.recipe : r).toList();
        emit(RecipeLoadedState(List.from(_filteredRecipes)));
      }
    });

    on<SearchRecipeEvent>((event, emit) {
      final query = event.query.toLowerCase();
      _filteredRecipes = _allRecipes.where((recipe) => recipe.title.toLowerCase().contains(query)).toList();
      emit(RecipeLoadedState(List.from(_filteredRecipes)));
    });

    on<FilterRecipeEvent>((event, emit) {
      final category = event.category;
      _filteredRecipes = _allRecipes.where((recipe) => recipe.category == category || category == 'All').toList();
      emit(RecipeLoadedState(List.from(_filteredRecipes)));
    });

    on<DeleteRecipeEvent>((event, emit) {
      _allRecipes.removeWhere((recipe) => recipe.id == event.recipeId);
      _filteredRecipes.removeWhere((recipe) => recipe.id == event.recipeId);
      emit(RecipeLoadedState(List.from(_filteredRecipes)));
    });

    on<DeleteAllRecipesEvent>((event, emit) {
      _allRecipes.clear();
      _filteredRecipes.clear();
      emit(RecipeLoadedState(List.from(_filteredRecipes)));
    });
  }
}
