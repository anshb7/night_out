import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String title;
  final String description;
  final double price;
  final String image;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });
}
