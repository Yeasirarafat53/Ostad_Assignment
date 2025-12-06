import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/sample_json.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Parse JSON
    final parsed = jsonDecode(sampleJson);
    final List recipesJson = parsed["recipes"];

    final List<Recipe> recipes =
        recipesJson.map((e) => Recipe.fromJson(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Recipes"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.restaurant_menu, size: 28, color: Colors.grey),
              title: Text(
                recipe.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                recipe.description,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
