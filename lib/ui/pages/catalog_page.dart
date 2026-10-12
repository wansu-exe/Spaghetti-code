import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../molecules/search_box.dart';
import '../organisms/add_product_form.dart';
import '../organisms/catalog_app_bar.dart';
import '../organisms/product_catalog.dart';
import '../templates/catalog_template.dart';

/// The only place that owns the real product list and wires data downward.
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Product> _products = [
    const Product(id: 1, name: 'Wireless Mouse', price: 599.0, category: 'Electronics', icon: Icons.mouse),
    const Product(id: 2, name: 'Mechanical Keyboard', price: 2499.0, category: 'Electronics', icon: Icons.keyboard),
    const Product(id: 3, name: 'Ceramic Mug', price: 149.0, category: 'Home', icon: Icons.coffee),
    const Product(id: 4, name: 'Notebook', price: 79.0, category: 'Office', icon: Icons.book),
    const Product(id: 5, name: 'Desk Lamp', price: 899.0, category: 'Home', icon: Icons.lightbulb),
    const Product(id: 6, name: 'Backpack', price: 1299.0, category: 'Accessories', icon: Icons.backpack),
    const Product(id: 7, name: 'Water Bottle', price: 299.0, category: 'Accessories', icon: Icons.local_drink),
  ];

  String _searchQuery = '';
  int _nextId = 8;

  void _addProduct({
    required String name,
    required double price,
    required String category,
    required String description,
  }) {
    setState(() {
      _products.add(Product(
        id: _nextId,
        name: name,
        price: price,
        category: category,
        icon: Icons.inventory_2,
        description: description,
      ));
      _nextId = _nextId + 1;
      _searchQuery = '';
    });
  }

  void _deleteProduct(Product product) {
    setState(() {
      _products.removeWhere((p) => p.id == product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _products.where((p) {
      return p.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return CatalogTemplate(
      appBar: const CatalogAppBar(),
      search: SearchBox(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
      catalog: ProductCatalog(
        products: filteredProducts,
        onDelete: _deleteProduct,
      ),
      form: AddProductForm(onSubmit: _addProduct),
    );
  }
}
