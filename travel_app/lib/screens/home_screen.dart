import 'package:flutter/material.dart';
import 'package:travel_app/widgets/gridview_practice.dart';
import 'package:travel_app/widgets/header_section.dart';
import 'package:travel_app/widgets/list_tile.dart';
import 'package:travel_app/widgets/top_destinations_section.dart';
import 'package:travel_app/widgets/trending_package.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Header with search bar
              HeaderSection(),
              SizedBox(height: 20),

              // Top destinations
              TopDestinationsSection(),

              // Trending package
              TravelCard(
                imageUrl: "https://picsum.photos/200",
                title: "Cox's Bazar Tour",
                time: "3 Days, 2 Nights",
                price: "\$250",
                onBook: () {},
              ),

              ListTilePractice(),
              GridviewPractice(),
            ],
          ),
        ),
      ),
    );
  }
}
