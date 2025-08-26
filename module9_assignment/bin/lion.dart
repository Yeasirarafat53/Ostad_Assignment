// lib/lion.dart
import 'animal.dart';

class Lion extends Animal {
  double _maneSize; // private

  Lion(super.name, this._maneSize);

  double get maneSize => _maneSize;
  set maneSize(double size) {
    if (size > 0) {
      _maneSize = size;
    } else {
      print("Mane size must be positive!");
    }
  }

  @override
  void makeSound() {
    print("Sound: Roar!");
  }
}
