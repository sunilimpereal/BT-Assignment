enum RecipeCategory {
  appetizer,
  mainCourse,
  dessert,
  beverage, all,
}

extension RecipeCategoryExtension on RecipeCategory {
  String get name {
    switch (this) {
      case RecipeCategory.appetizer:
        return 'Appetizer';
      case RecipeCategory.mainCourse:
        return 'Main Course';
      case RecipeCategory.dessert:
        return 'Dessert';
      case RecipeCategory.beverage:
        return 'Beverage';
       case RecipeCategory.all:
        return 'All';
    }
  }
}

const List<RecipeCategory> recipeCategories = [
  RecipeCategory.appetizer,
  RecipeCategory.mainCourse,
  RecipeCategory.dessert,
  RecipeCategory.beverage,
];
