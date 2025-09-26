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
      title: 'Courses UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CourseGridPage(),
    );
  }
}

class CourseGridPage extends StatelessWidget {
  const CourseGridPage({super.key});

  final List<Map<String, String>> courses = const [
    {
      "image":
          "https://cdn.ostad.app/course/cover/2024-12-17T11-35-19.890Z-Course%20Thumbnail%2012.jpg",
      "title": "Full Stack Web Development with JavaScript (MERN)",
      "batch": "ব্যাচ ৬",
      "duration": "৬ সিট বাকি",
      "classHour": "৬ দিন বাকি",
    },
    {
      "image":
          "https://cdn.ostad.app/course/cover/2024-12-19T15-48-52.487Z-Full-Stack-Web-Development-with-Python,-Django-&-React.jpg",
      "title": "Full Stack Web Development with Python, Django & React",
      "batch": "ব্যাচ ৫",
      "duration": "৬০ সিট বাকি",
      "classHour": "৮৬ দিন বাকি",
    },
    {
      "image":
          "https://cdn.ostad.app/course/photo/2024-12-18T15-29-34.261Z-Untitled-1%20(23).jpg",
      "title": "Full Stack Web Development with ASP.Net Core",
      "batch": "ব্যাচ ৪",
      "duration": "৬৪ সিট বাকি",
      "classHour": "৪৬ দিন বাকি",
    },
    {
      "image":
          "https://cdn.ostad.app/course/cover/2024-12-18T15-24-44.114Z-Untitled-1%20(21).jpg",
      "title": "SQA: Manual & Automated Testing",
      "batch": "ব্যাচ ৩",
      "duration": "৭৬ সিট বাকি",
      "classHour": "৬৭ দিন বাকি",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text("Module 13 Assignment"),
  centerTitle: true, // টাইটেল সেন্টারে আনবে
  backgroundColor: Colors.cyan, // তোমার পছন্দমতো কালার দাও
),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: GridView.builder(
          itemCount: courses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // প্রতি row তে ২ টা card
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.65, // height নিয়ন্ত্রণ করার জন্য
          ),
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseCard(course: course);
          },
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, String> course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image part
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              course["image"]!,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 5),
          // Badges with icons
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBadge(course["batch"]!), // প্রথমটা icon ছাড়া
                const SizedBox(width: 1),
                _buildBadge(course["duration"]!, Icons.people_outline),
                const SizedBox(width: 1),
                _buildBadge(course["classHour"]!, Icons.schedule_outlined),
              ],
            ),
          ),

          // Divider এর height property ব্যবহার করে উপরে ও নিচে স্পেস দেওয়া হয়েছে
          const Divider(height: 5, thickness: 0.5),

          // Content part
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges with icons
                  Text(
                    course["title"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2, // Title বড় হলে ২ লাইনের বেশি দেখাবে না
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  // Button একদম নিচে থাকবে
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("বিস্তারিত দেখুন →"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _buildBadge মেথড আইকন optional করা হলো
  Widget _buildBadge(String text, [IconData? icon]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: Colors.black54),
            const SizedBox(width: 2),
          ],
          Text(
            text,
            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
