import 'package:flutter/material.dart';

import '../atoms/app_text_form_field.dart';

class ProductPriceField extends StatelessWidget {
  const ProductPriceField({
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
          labelText: 'Price',
          controller: controller,
          keyboardType: TextInputType.number,
          validator: validator,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
