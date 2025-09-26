import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contact List UI",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {"name": "Arif", "phone": "01877-777777"},
      {"name": "Akib", "phone": "01857-777777"},
      {"name": "Hasan", "phone": "01745-777777"},
      {"name": "Jisan", "phone": "01745-777777"},
      {"name": "Arafat", "phone": "01745-777777"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Name field
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Yeasir Arafat",
              ),
            ),
            const SizedBox(height: 10),

            // Phone field
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "01600120000",
              ),
            ),
            const SizedBox(height: 12),

            // Add button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text("Add"),
              ),
            ),
            const SizedBox(height: 12),

            // Contact list
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, size: 30),
                      title: Text(
                        contact["name"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      subtitle: Text(contact["phone"]!),
                      trailing: const Icon(Icons.call, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
