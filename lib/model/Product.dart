class Product {
  String id;
  String name;
  double price;
  String description;

  Product({required this.id, required this.name, required this.price, required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
