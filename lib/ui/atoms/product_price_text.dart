import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText(this.price, {super.key});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      'PHP ${price.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
    );
  }
}
