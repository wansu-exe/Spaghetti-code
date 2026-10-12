import 'package:flutter/material.dart';

import '../atoms/search_text_field.dart';
import '../atoms/section_title.dart';

/// "Search Products" heading + search input.
class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Search Products'),
        const SizedBox(height: 8),
        SearchTextField(
          hintText: 'Type a product name...',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
