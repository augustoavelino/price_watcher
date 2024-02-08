import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Text(
              'Menu',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Products'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/product_list'),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Categories'),
            onTap: () => Navigator.pushReplacementNamed(
                context, '/product_category_list'),
          ),
        ],
      ),
    );
  }
}
