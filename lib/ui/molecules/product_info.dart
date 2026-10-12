import 'package:flutter/material.dart';

import '../atoms/product_category_text.dart';
import '../atoms/product_name_text.dart';
import '../atoms/product_price_text.dart';

/// Name / category / price stacked together.
class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.name,
    required this.category,
    required this.price,
  });

  final String name;
  final String category;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductNameText(name),
        const SizedBox(height: 4),
        ProductCategoryText(category),
        const SizedBox(height: 4),
        ProductPriceText(price),
      ],
    );
  }
}
