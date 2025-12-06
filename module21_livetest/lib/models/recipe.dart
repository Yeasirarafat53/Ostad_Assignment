class Recipe {
  final String title;
  final String description;

  Recipe({
    required this.title,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json["title"],
      description: json["description"],
    );
  }
}
