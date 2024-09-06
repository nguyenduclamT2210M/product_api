import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Product.dart';

class ProductService {
  final String baseUrl = 'https://t2210m-flutter.onrender.com/products';


  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error occurred: $error');
      throw error;
    }
  }


  Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create product');
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
