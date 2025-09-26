// top_destinations_section.dart
import 'package:flutter/material.dart';

class TopDestinationsSection extends StatelessWidget {
  const TopDestinationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageGridPage(); // শুধু ImageGridPage call করলাম
  }
}

class ImageGridPage extends StatelessWidget {
  const ImageGridPage({super.key});

  final List<Map<String, String>> items = const [
    {
      "title": "Cox's Bazar",
      "url":
          "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=800&q=80",
    },
    {
      "title": "Sundarbans",
      "url":
          "https://images.unsplash.com/photo-1526772662000-3f88f10405ff?auto=format&fit=crop&w=800&q=80",
    },
    {
      "title": "Saint Martin",
      "url":
          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80",
    },
    {
      "title": "Bandarban",
      "url":
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=80",
    },
  ];

  Widget buildImageCard(String url, String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.broken_image, size: 48)),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8),
            color: Colors.black45,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ❌ Scaffold বাদ দিলাম
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // <-- add this
        children: [
          Text(
            "This is destination card",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            shrinkWrap: true, // ✅ important (scroll conflict fix)
            physics: const NeverScrollableScrollPhysics(), // ✅ scroll issue fix
            children: items
                .map((item) => buildImageCard(item["url"]!, item["title"]!))
                .toList(),
          ),
        ],
      ),
    );
  }
}
