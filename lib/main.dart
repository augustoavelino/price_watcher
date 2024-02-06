import 'package:flutter/material.dart';
import 'package:price_watcher/screens/home_screen.dart';

void main() {
  runApp(const PriceWatcher());
}

class PriceWatcher extends StatelessWidget {
  const PriceWatcher({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Price Watcher',
      home: HomeScreen(),
    );
  }
}
