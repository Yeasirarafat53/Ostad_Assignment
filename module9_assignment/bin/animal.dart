// lib/animal.dart
abstract class Animal {
  final String _name; // private field

  Animal(this._name); // constructor

  String getName() => _name; // concrete method

  void makeSound(); // abstract method
}
