import 'package:flutter/material.dart';

import '../atoms/app_bar_title.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AppBarTitle('Messy Catalog'),
      backgroundColor: Colors.indigo,
    );
  }
}
