import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../atoms/product_icon_badge.dart';
import '../molecules/product_actions.dart';
import '../molecules/product_info.dart';

/// One catalog row. Receives a product and an `onDelete` callback; it never
/// owns or mutates the product list. The "added to cart" feedback is purely
/// local UI behaviour, so it lives here.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onDelete});

  final Product product;
  final VoidCallback onDelete;

  void _addToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added ${product.name} to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ProductIconBadge(icon: product.icon),
          const SizedBox(width: 12),
          Expanded(
            child: ProductInfo(
              name: product.name,
              category: product.category,
              price: product.price,
            ),
          ),
          ProductActions(
            onAddToCart: () => _addToCart(context),
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}
