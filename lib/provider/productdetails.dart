import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        title: json['title'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl']);
  }
}
