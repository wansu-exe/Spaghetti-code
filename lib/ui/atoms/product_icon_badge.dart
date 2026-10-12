import 'package:flutter/material.dart';

class ProductIconBadge extends StatelessWidget {
  const ProductIconBadge({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 32, color: Colors.indigo),
    );
  }
}
