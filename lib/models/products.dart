import 'package:flutter/material.dart';
import 'package:price_watcher/models/product.dart';

class Products extends ChangeNotifier {
  final List<Product> _list;

  Products(this._list);

  List<Product> get list => _list;
  int get length => list.length;
  Product elementAt(int index) => list.elementAt(index);

  void add(Product product) {
    _list.add(product);
    notifyListeners();
  }

  void removeAt(int index) {
    _list.removeAt(index);
    notifyListeners();
  }
}
