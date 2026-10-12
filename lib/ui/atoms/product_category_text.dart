import 'package:flutter/material.dart';

class ProductCategoryText extends StatelessWidget {
  const ProductCategoryText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
    );
  }
}
