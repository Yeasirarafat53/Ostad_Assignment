import 'package:flutter/material.dart';

class TravelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;
  final String price;
  final VoidCallback onBook;

  const TravelCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.price,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // fixed height for card
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            // Left Side: Image (full height)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                width: 120,
                height: double.infinity, // full height of card
                fit: BoxFit.cover,
              ),
            ),

            // Right Side: Details with padding
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onBook,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Book Now"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),






          ],
        ),
      ),
    );
  }
}
