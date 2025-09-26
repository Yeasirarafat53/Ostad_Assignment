import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DestinationCard extends StatelessWidget {
  String? name;
  String? imageUrl;

  DestinationCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imageUrl!, fit: BoxFit.cover, height: 120),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
