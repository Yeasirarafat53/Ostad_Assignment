import 'package:flutter/material.dart';
import 'package:module16_api/home_screen.dart';

void main(){
  runApp(const myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My First flutter app',
      home: const HomeScreen(),
    );
  }
}