import 'package:flutter/material.dart';


class AppText {
  // General Texts
  static const String appTitle = 'Recipe App';
  static const String noRecipesAvailable = 'No Recipes Available';
  static const String somethingWentWrong = 'Something went wrong';
  static const String saveButtonLabel = 'Save Recipe';
  static const String addButtonTooltip = 'Add new recipe';
  static const String clearListButtonTooltip = 'Clear all recipes';

  // New Recipe Screen Texts
  static const String newRecipeTitle = 'New Recipe';
  static const String editRecipeTitle = 'Edit Recipe';
  static const String titleLabel = 'Title';
  static const String ingredientsTitle = 'Ingredients';
  static const String preparationStepsTitle = 'Preparation Steps';
  static const String categoryTitle = 'Category';
  static const String newItemLabel = 'New Item';
  static const String categoryLabel = 'Category';

  // Filter Categories
  static const String allCategories = 'All Categories';
  static const String appetizer = 'Appetizer';
  static const String mainCourse = 'Main Course';
  static const String dessert = 'Dessert';
  static const String beverage = 'Beverage';

  // Validation Messages
  static const String enterError = 'Please enter a ';
  static const String emptyFieldError = 'This field cannot be empty';

  // Search and Filter
  static const String searchHint = 'Search recipes...';
}


class AppTextStyles {
  // General Text Styles
  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static final TextStyle subtitle = TextStyle(
    fontSize: 14.0,
    color: Colors.grey[600],
  );

  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    color: Colors.black87,
  );

  // AppBar Styles
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  // Button Styles
  static const TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  // Section Titles
  static final TextStyle sectionTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    backgroundColor: Colors.blue[50],
    // padding: const EdgeInsets.all(8.0),
    // borderRadius: BorderRadius.circular(6.0),
  );
}
