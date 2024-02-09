import 'package:flutter/material.dart';
import 'package:price_watcher/components/app_drawer.dart';
import 'package:price_watcher/models/product.dart';
import 'package:price_watcher/models/product_categories.dart';
import 'package:price_watcher/models/product_category.dart';
import 'package:price_watcher/models/products.dart';
import 'package:price_watcher/themes/app_colors.dart';
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
      drawer: const AppDrawer(),
      body: Consumer<Products>(
        builder: (consumerContext, products, _) {
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(
                0, 0, 0, MediaQuery.of(context).padding.bottom),
            itemCount: products.length,
            itemBuilder: (builderContext, index) {
              final product = products.elementAt(index);
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: AppColors.destructiveAction,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                confirmDismiss: (_) =>
                    _showDeleteConfimationDialog(context, product),
                onDismissed: (_) => products.removeAt(index),
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.category.name),
                  leading: Icon(
                    product.category.icon,
                    size: 32,
                  ),
                  iconColor: product.category.color,
                  minVerticalPadding: 0,
                ),
              );
            },
            separatorBuilder: (builderContext, _) => const Divider(height: 0),
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
                          id: const Uuid().v4(),
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

  Future<bool?> _showDeleteConfimationDialog(
      BuildContext context, Product product) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Removing product'),
        content: Text('Are you sure you want to delete\n\'${product.name}\'?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: ButtonStyle(
                foregroundColor:
                    const MaterialStatePropertyAll(AppColors.destructiveAction),
                overlayColor: MaterialStatePropertyAll(
                    AppColors.destructiveAction.withOpacity(0.15))),
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    return result;
  }
}
