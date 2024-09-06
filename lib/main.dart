import 'package:flutter/material.dart';
import 'package:untitled5/screen/CreateProduct.dart';
import 'package:untitled5/screen/ProductUpdateScreen.dart';
import 'package:untitled5/service/ProductService.dart';

import 'model/Product.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService apiService = ProductService();
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = apiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Điều hướng đến màn hình thêm sản phẩm
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductAddScreen()),
              ).then((_) {
                // Sau khi thêm sản phẩm, làm mới danh sách
                setState(() {
                  futureProducts = apiService.fetchProducts();
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Chuyển đến màn hình sửa
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductEditScreen(product: product)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          try {
                            await apiService.deleteProduct(product.id);
                            setState(() {
                              futureProducts = apiService.fetchProducts();
                            });
                          } catch (error) {
                            print('Error deleting product: $error');
                          }
                        },
                      ),
                    ],
                  ),
                );

              },
            );
          }
        },
      ),
    );
  }
}


