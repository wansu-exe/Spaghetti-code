import 'package:flutter/material.dart';

import '../atoms/app_text_form_field.dart';

class ProductDescriptionField extends StatelessWidget {
  const ProductDescriptionField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          labelText: 'Description',
          controller: controller,
          maxLines: 3,
          alignLabelWithHint: true,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
