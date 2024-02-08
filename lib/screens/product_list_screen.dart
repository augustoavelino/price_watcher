import 'package:flutter/material.dart';
import 'package:price_watcher/models/product.dart';
import 'package:price_watcher/models/product_categories.dart';
import 'package:price_watcher/models/product_category.dart';
import 'package:price_watcher/models/products.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Consumer<Products>(
        builder: (consumerContext, list, _) {
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(
                20, 0, 20, MediaQuery.of(context).padding.bottom),
            itemCount: list.length,
            itemBuilder: (builderContext, index) {
              final item = list.elementAt(index);
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.category.name),
                leading: Icon(item.category.icon),
                iconColor: item.category.color,
              );
            },
            separatorBuilder: (builderContext, index) =>
                const SizedBox(height: 8),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('new_product_button'),
        onPressed: () => _showNewProductDialog(context),
        tooltip: 'New Product',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _showNewProductDialog(BuildContext context) {
    ProductCategories categories =
        Provider.of<ProductCategories>(context, listen: false);

    TextEditingController nameController = TextEditingController();
    ProductCategory selectedCategory = categories.list.first;

    showDialog(
      context: context,
      builder: (dialogContext) =>
          Consumer<Products>(builder: (consumerContext, list, _) {
        return AlertDialog(
          title: const Text('New Product'),
          scrollable: true,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  StatefulBuilder(
                    builder: (statefulContext, innerSetState) => DropdownButton(
                      isExpanded: true,
                      value: selectedCategory,
                      onChanged: (newCategory) => innerSetState(() {
                        if (newCategory != null) {
                          selectedCategory = newCategory;
                        }
                      }),
                      items: categories.list
                          .map((ProductCategory category) =>
                              DropdownMenuItem<ProductCategory>(
                                value: category,
                                child: Text(category.name),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Consumer<Products>(
                builder: (consumerContext, products, _) => TextButton(
                      onPressed: () async {
                        products.add(Product(
                          id: const Uuid().v8(),
                          name: nameController.text,
                          category: selectedCategory,
                          image: null,
                        ));
                        Navigator.pop(dialogContext);
                      },
                      child: const Text('Save'),
                    )),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
          ],
        );
      }),
    );
  }
}
