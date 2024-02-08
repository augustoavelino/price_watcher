import 'package:flutter/material.dart';
import 'package:price_watcher/components/app_drawer.dart';
import 'package:price_watcher/components/color_picker.dart';
import 'package:price_watcher/components/icon_picker.dart';
import 'package:price_watcher/models/product_categories.dart';
import 'package:price_watcher/models/product_category.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductCategoryListScreen extends StatefulWidget {
  const ProductCategoryListScreen({super.key});

  @override
  State<ProductCategoryListScreen> createState() =>
      _ProductCategoryListScreenState();
}

class _ProductCategoryListScreenState extends State<ProductCategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<ProductCategories>(
        builder: (consumerContext, categories, _) => ListView.separated(
          itemCount: categories.length,
          itemBuilder: (listContext, index) {
            final category = categories.elementAt(index);
            return ListTile(
              title: Text(category.name),
              iconColor: category.color,
              leading: Icon(category.icon),
            );
          },
          separatorBuilder: (builderContext, _) => const SizedBox(height: 8),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('new_category_button'),
        onPressed: () => _showNewCategoryDialog(context),
        tooltip: 'New Category',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _showNewCategoryDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    IconData selectedIcon = Icons.favorite;
    Color selectedColor = Colors.red;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        scrollable: true,
        title: const Text('New Category'),
        content: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              StatefulBuilder(builder: (context, innerSetState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        selectedIcon,
                        size: 32,
                        color: selectedColor,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await showIconPicker(
                            context: context,
                            defalutIcon: selectedIcon,
                          );
                          if (result != null) {
                            innerSetState(() {
                              selectedIcon = result;
                            });
                          }
                        },
                        child: const Text('Select Icon'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await showColorPicker(
                            context: context,
                            defaultColor: selectedColor,
                          );
                          if (result != null) {
                            innerSetState(() {
                              selectedColor = result;
                            });
                          }
                        },
                        child: const Text('Select Color'),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        actions: <Widget>[
          Consumer<ProductCategories>(
              builder: (consumerContext, categories, _) => TextButton(
                    onPressed: () async {
                      categories.add(ProductCategory(
                        id: const Uuid().v8(),
                        name: nameController.text,
                        icon: selectedIcon,
                        color: selectedColor,
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
      ),
    );
  }
}
