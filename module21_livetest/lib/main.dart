import 'package:flutter/material.dart';
import 'screens/recipe_list_page.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,   // Header blue
          foregroundColor: Colors.white,  // Text/icons white
        ),
      ),
      home: const RecipeListPage(),
    );
  }
}

