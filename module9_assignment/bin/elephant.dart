// lib/elephant.dart
import 'animal.dart';

class Elephant extends Animal {
  double _trunkLength; // private

  Elephant(super.name, this._trunkLength);

  double get trunkLength => _trunkLength;
  set trunkLength(double length) {
    if (length > 0) {
      _trunkLength = length;
    } else {
      print("Trunk length must be positive!");
    }
  }

  @override
  void makeSound() {
    print("Sound: Trumpet!");
  }
}
