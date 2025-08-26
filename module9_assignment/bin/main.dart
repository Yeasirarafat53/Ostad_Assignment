
import 'animal.dart';
import 'lion.dart';
import 'elephant.dart';
import 'parrot.dart';

void main() {
  List<Animal> zoo = [];

  // Adding instances
  zoo.add(Lion("Lion Simba", 1.2));
  zoo.add(Elephant("Elephant Dumbo", 2.5));
  zoo.add(Parrot("Parrot Polly", 50));

  // Loop through zoo list
  for (var animal in zoo) {
    print("Name: ${animal.getName()}");

    if (animal is Lion) print("Mane Size: ${animal.maneSize} meters");
    if (animal is Elephant) print("Trunk Length: ${animal.trunkLength} meters");
    if (animal is Parrot) print("Vocabulary Size: ${animal.vocabularySize} words");

    animal.makeSound();
    print("------");
  }
}
