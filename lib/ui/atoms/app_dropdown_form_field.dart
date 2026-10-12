import 'package:flutter/material.dart';

class AppDropdownFormField extends StatelessWidget {
  const AppDropdownFormField({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String labelText;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: labelText),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
