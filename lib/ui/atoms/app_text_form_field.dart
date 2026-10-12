import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.alignLabelWithHint,
  });

  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool? alignLabelWithHint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: alignLabelWithHint,
      ),
      validator: validator,
    );
  }
}
