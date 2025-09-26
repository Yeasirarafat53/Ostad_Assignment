import 'package:flutter/material.dart';

class ListTilePractice extends StatelessWidget {
  const ListTilePractice({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // কয়টা item দেখাবে
      shrinkWrap: true, // SingleChildScrollView এর ভিতরে কাজ করার জন্য
      physics: const NeverScrollableScrollPhysics(), // আলাদা scroll করবে না
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.phone),
          title: Text("Hello Arif $index"),
          subtitle: Text("This is subtitle $index"),
          trailing: const Icon(Icons.delete),
        );
      },
    );
  }
}
