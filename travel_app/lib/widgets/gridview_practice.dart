import 'package:flutter/material.dart';

class GridviewPractice extends StatelessWidget {
  const GridviewPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // প্রতি row তে কয়টা column থাকবে
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      children: List.generate(10, (index) {
        return Card(
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.phone, color: Colors.white),
              SizedBox(height: 8), // gap
              Text("Cash Out", style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      }),
    );
  }
}
