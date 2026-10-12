import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../atoms/section_title.dart';
import 'product_card.dart';

/// "Catalog" heading + the list of product cards for whatever products the
/// Page hands down.
class ProductCatalog extends StatelessWidget {
  const ProductCatalog({
    super.key,
    required this.products,
    required this.onDelete,
  });

  final List<Product> products;
  final ValueChanged<Product> onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Catalog'),
        const SizedBox(height: 8),
        Column(
          children: products
              .map((p) => ProductCard(product: p, onDelete: () => onDelete(p)))
              .toList(),
        ),
      ],
    );
  }
}
