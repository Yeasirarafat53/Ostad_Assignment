
import 'animal.dart';

class Parrot extends Animal {
  int _vocabularySize; // private

  Parrot(super.name, this._vocabularySize);

  int get vocabularySize => _vocabularySize;
  set vocabularySize(int size) {
    if (size >= 0) {
      _vocabularySize = size;
    } else {
      print("Vocabulary size cannot be negative!");
    }
  }

  @override
  void makeSound() {
    print("Sound: Squawk!");
  }
}

