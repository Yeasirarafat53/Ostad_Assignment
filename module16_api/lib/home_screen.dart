import 'package:flutter/material.dart';
import 'package:module16_api/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List posts = [];
  bool isLoading = true;

  // step 1: Create ApiService object

  final ApiService apiService = ApiService();

  // step 2: Api calling into initState

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  // step 3: data load function
  Future<void> loadPosts() async {
    try {
      final data = await apiService.fetchPosts();
      setState(() {
        posts = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Api Fetching")),
  //     body: isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : ListView.builder(
  //           itemCount: posts.length,
  //             itemBuilder: (context, index) {
  //               final post = posts[index];
  //               return Card(
  //                 margin: const EdgeInsets.all(8),
  //                 child: ListTile(
  //                   title: Text(post['title']),
  //                   subtitle: Text(post['body']),
  //                 ),
  //               );
  //             },
  //           ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Fetching"),
        // titleTextStyle: TextStyle(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: posts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return Card(
                    elevation: 3,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // child:

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.start,

                    //     children: [
                    //       Text(
                    //         post['title'],
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 14,
                    //         ),
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //       const SizedBox(height: 5),
                    //       Text(
                    //         post['body'],
                    //         style: const TextStyle(
                    //           fontSize: 12,
                    //           color: Colors.black54,
                    //         ),
                    //         maxLines: 3,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    clipBehavior: Clip.antiAlias, // image corner cut করবে না
                    child: Image.network(
                      post['download_url'], // ✅ image link
                      fit: BoxFit.cover, // পুরো cell টা cover করবে
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(Icons.broken_image, size: 40),
                          ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
