import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Product.dart';
import '../service/ProductService.dart';

class ProductAddScreen extends StatefulWidget {
  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final ProductService apiService = ProductService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void addProduct() async {
    Product newProduct = Product(
      id: '',
      name: nameController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
    );

    try {
      await apiService.createProduct(newProduct);
      Navigator.pop(context);
    } catch (error) {
      print('Error adding product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
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
              onPressed: addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
