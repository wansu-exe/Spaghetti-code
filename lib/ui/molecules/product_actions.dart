import 'package:flutter/material.dart';

import '../atoms/delete_icon_button.dart';
import '../atoms/primary_button.dart';

/// "Add to Cart" button above a delete icon.
class ProductActions extends StatelessWidget {
  const ProductActions({
    super.key,
    required this.onAddToCart,
    required this.onDelete,
  });

  final VoidCallback onAddToCart;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          onPressed: onAddToCart,
          child: const Text('Add to Cart'),
        ),
        const SizedBox(height: 6),
        DeleteIconButton(onPressed: onDelete),
      ],
    );
  }
}
