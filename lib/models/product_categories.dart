import 'package:flutter/material.dart';
import 'package:price_watcher/models/product_category.dart';

class ProductCategories extends ChangeNotifier {
  final List<ProductCategory> _list;

  ProductCategories(this._list);

  List<ProductCategory> get list => _list;
  int get length => list.length;
  ProductCategory elementAt(int index) => list.elementAt(index);

  void add(ProductCategory category) {
    _list.add(category);
    notifyListeners();
  }

  void removeAt(int index) {
    _list.removeAt(index);
    notifyListeners();
  }
}
