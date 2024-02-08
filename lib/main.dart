import 'package:flutter/material.dart';
import 'package:price_watcher/models/product_categories.dart';
import 'package:price_watcher/models/product_category.dart';
import 'package:price_watcher/models/products.dart';
import 'package:price_watcher/screens/home_screen.dart';
import 'package:price_watcher/screens/product_list_screen.dart';
import 'package:price_watcher/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products([])),
        ChangeNotifierProvider(
          create: (context) => ProductCategories([
            ProductCategory(
                id: '001',
                name: 'Groceries',
                icon: Icons.free_breakfast_rounded,
                color: Colors.blue),
            ProductCategory(
                id: '002',
                name: 'Drinks',
                icon: Icons.local_drink_rounded,
                color: Colors.orange),
            ProductCategory(
                id: '003',
                name: 'Utilities',
                icon: Icons.gas_meter_rounded,
                color: Colors.blueGrey),
          ]),
        ),
      ],
      child: const PriceWatcher(),
    ),
  );
}

class PriceWatcher extends StatelessWidget {
  const PriceWatcher({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Watcher',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const ProductListScreen(),
    );
  }
}
