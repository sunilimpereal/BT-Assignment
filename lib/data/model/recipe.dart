
class Recipe {
    int id;
    String title;
    List<String> ingredients;
    List<String> preparationSteps;
    String category;

    Recipe({
        required this.id,
        required this.title,
        required this.ingredients,
        required this.preparationSteps,
        required this.category,
    });

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        title: json["title"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        preparationSteps: List<String>.from(json["preparationSteps"].map((x) => x)),
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "preparationSteps": List<dynamic>.from(preparationSteps.map((x) => x)),
        "category": category,
    };
}
