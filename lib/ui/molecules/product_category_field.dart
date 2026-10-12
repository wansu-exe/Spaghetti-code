import 'package:flutter/material.dart';

import '../atoms/app_dropdown_form_field.dart';

class ProductCategoryField extends StatelessWidget {
  const ProductCategoryField({
    super.key,
    required this.value,
    required this.categories,
    required this.onChanged,
  });

  final String value;
  final List<String> categories;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDropdownFormField(
          labelText: 'Category',
          value: value,
          items: categories,
          onChanged: onChanged,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
