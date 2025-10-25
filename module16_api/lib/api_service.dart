import 'dart:convert'; // JSON ডিকোড করার জন্য
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchPosts() async {
    // step 1: Api te request pathaw
    final response = await http.get(
      // Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      Uri.parse("https://picsum.photos/v2/list?page=2&limit=15"),
      headers: {'Accept': 'application/json'},
    );

    // step 2: response checking

    if (response.statusCode == 200) {
      // step 3: JSON theke data decode kora
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed");
    }
  }
}
