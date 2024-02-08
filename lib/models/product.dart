import 'package:price_watcher/models/product_category.dart';

class Product {
  final String id;
  final String name;
  final ProductCategory category;
  final String? image;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });
}
