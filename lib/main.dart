import 'package:flutter/material.dart';
import 'package:price_watcher/models/product_categories.dart';
import 'package:price_watcher/models/product_category.dart';
import 'package:price_watcher/models/products.dart';
import 'package:price_watcher/screens/home_screen.dart';
import 'package:price_watcher/screens/product_category_list_screen.dart';
import 'package:price_watcher/screens/product_list_screen.dart';
import 'package:price_watcher/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  const uuid = Uuid();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products([])),
        ChangeNotifierProvider(
          create: (context) => ProductCategories([
            ProductCategory(
                id: uuid.v4(),
                name: 'Groceries',
                icon: Icons.coffee,
                color: Colors.orange),
            ProductCategory(
                id: uuid.v4(),
                name: 'Party',
                icon: Icons.nightlife,
                color: Colors.deepPurple),
            ProductCategory(
                id: uuid.v4(),
                name: 'Gaming',
                icon: Icons.videogame_asset,
                color: Colors.blue),
            ProductCategory(
                id: uuid.v4(),
                name: 'Health',
                icon: Icons.health_and_safety,
                color: Colors.green),
            ProductCategory(
                id: uuid.v4(),
                name: 'Streaming',
                icon: Icons.ondemand_video,
                color: Colors.red),
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
      routes: {
        '/': (context) => const HomeScreen(),
        '/product_list': (context) => const ProductListScreen(),
        '/product_category_list': (context) =>
            const ProductCategoryListScreen(),
      },
    );
  }
}
