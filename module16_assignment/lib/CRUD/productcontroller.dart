import 'dart:convert';

import 'package:module16_assignment/CRUD/Model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:module16_assignment/CRUD/utils/urls.dart';

class ProductController {
  List<Data> products = [];

  Future fetchProduct() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<bool> createProduct(
    String name,
    String img,
    int qty,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 200) {
      await fetchProduct();
      return true;
    } else {
      return false;
    }
  }

 Future<bool> UpdateProduct(
  String productId,
    String name,
    String img,
    int qty,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.updateProduct(productId)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 200) {
      await fetchProduct();
      return true;
    } else {
      return false;
    }
  }


  Future<bool> DeleteProduct(String productId) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(productId)));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
