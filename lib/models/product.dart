import 'package:flutter/material.dart';

/// Core data model for a catalog item. Only Pages (and organisms that merely
/// receive it as a parameter) may import this; Templates never do.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.icon,
    this.description = '',
  });

  final int id;
  final String name;
  final double price;
  final String category;
  final IconData icon;
  final String description;
}

const List<String> kProductCategories = [
  'Electronics',
  'Home',
  'Office',
  'Accessories',
];

String get kDefaultCategory => kProductCategories.first;
