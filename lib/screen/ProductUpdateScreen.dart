import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Product.dart';
import '../service/ProductService.dart';

class ProductEditScreen extends StatefulWidget {
  final Product product;

  ProductEditScreen({required this.product});

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final ProductService apiService = ProductService();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    descriptionController = TextEditingController(text: widget.product.description);
    priceController = TextEditingController(text: widget.product.price.toString());
  }

  void updateProduct() async {
    Product updatedProduct = Product(
      id: widget.product.id,
      name: nameController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
    );

    try {
      await apiService.updateProduct(widget.product.id, updatedProduct);
      Navigator.pop(context); // Quay lại danh sách sản phẩm sau khi cập nhật thành công
    } catch (error) {
      print('Error updating product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: updateProduct,
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
