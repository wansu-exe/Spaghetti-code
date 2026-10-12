import 'package:flutter/material.dart';

import '../atoms/app_text_form_field.dart';

class ProductNameField extends StatelessWidget {
  const ProductNameField({
    super.key,
    required this.controller,
    required this.validator,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          labelText: 'Product Name',
          controller: controller,
          validator: validator,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
