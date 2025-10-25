import 'package:flutter/material.dart';
import 'package:module16_assignment/CRUD/productcontroller.dart';
import 'package:module16_assignment/CRUD/widget/product_card.dart';

class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future loadProducts() async {
    await productController.fetchProduct();
    setState(() {}); // ✅ শুধু UI refresh হবে
  }

  productDialogue({
    String? id,
    String? name,
    String? img,
    int? qty,
    int? unitPrice,
    int? totalPrice,
    required bool isUpdate,
  }) {
    TextEditingController productNameController = TextEditingController(
      text: name,
    );
    TextEditingController productIMGController = TextEditingController(
      text: img,
    );
    TextEditingController productQTYController = TextEditingController(
      text: qty != null ? qty.toString() : '',
    );
    TextEditingController productUnitPriceController = TextEditingController(
      text: unitPrice != null ? unitPrice.toString() : '',
    );
    TextEditingController productTotalPriceController = TextEditingController(
      text: totalPrice != null ? totalPrice.toString() : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update Product" : "Add Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productIMGController,
              decoration: InputDecoration(labelText: 'Product Image'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productQTYController,
              decoration: InputDecoration(labelText: 'Product Qty'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productUnitPriceController,
              decoration: InputDecoration(labelText: 'Product Unit Price'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productTotalPriceController,
              decoration: InputDecoration(labelText: 'Product Total Price'),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),

                ElevatedButton(
                  // onPressed: () async {
                  //   await productController.createProduct(
                  //     productNameController.text,
                  //     productIMGController.text,
                  //     int.parse(productQTYController.text),
                  //     int.parse(productUnitPriceController.text),
                  //     int.parse(productTotalPriceController.text),
                  //   );
                  //   setState(() {});
                  //   Navigator.pop(context);
                  // },
                  onPressed: () async {
                    if (isUpdate) {
                      await productController.UpdateProduct(
                        id.toString(),
                        productNameController.text,
                        productIMGController.text,
                        int.parse(productQTYController.text),
                        int.parse(productUnitPriceController.text),
                        int.parse(productTotalPriceController.text),
                      );
                    } else {
                      await productController.createProduct(
                        productNameController.text,
                        productIMGController.text,
                        int.parse(productQTYController.text),
                        int.parse(productUnitPriceController.text),
                        int.parse(productTotalPriceController.text),
                      );
                    }

                    await loadProducts();
                    Navigator.pop(context);
                    setState(() {});
                  },

                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product CRUD'),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productDialogue(isUpdate: false);
        },
        child: Icon(Icons.add),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return ProductCard(
            product: product,
            onDelete: () {
              productController.DeleteProduct(product.sId.toString()).then((
                value,
              ) async {
                if (value) {
                  await productController.fetchProduct();
                  setState(() {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Product Deleted')));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something wrong...!')),
                  );
                }
              });
            },

            onEdit: () {
              productDialogue(
                name: product.productName,
                img: product.img,
                id: product.sId,
                unitPrice: product.unitPrice,
                totalPrice: product.totalPrice,
                qty: product.qty,
                isUpdate: true,
              );
            },
          );
        },
      ),
    );
  }
}
