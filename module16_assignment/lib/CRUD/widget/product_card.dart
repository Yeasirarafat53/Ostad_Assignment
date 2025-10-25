import 'package:flutter/material.dart';
import 'package:module16_assignment/CRUD/Model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;

  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          // ✅ Network image dynamic
          SizedBox(
            height: 140,
            child: Image.network(
              (product.img != null && product.img.toString().startsWith('http'))
                  ? product.img.toString()
                  : 'https://previews.123rf.com/images/sabinarahimova/sabinarahimova1809/sabinarahimova180900153/107444841-no-photo-vector-icon-isolated-on-transparent-background-no-photo-logo-concept.jpg',
            ),
          ),

          const SizedBox(height: 8),

          // ✅ Product Name
          Text(
            product.productName ?? 'Unknown Product',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          // ✅ Price & Quantity
          Text(
            "Price: \$${product.unitPrice ?? 0} | QTY: ${product.qty ?? 0}",
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),

          const Spacer(),

          // ✅ Edit / Delete buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: Colors.orange),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
