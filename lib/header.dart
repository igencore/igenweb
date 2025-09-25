// Archivo: lib/header.dart

import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('iGenCore'),
      centerTitle: false,
      actions: [
        // Aquí irán los botones de dark mode y cambio de idioma
        IconButton(
          onPressed: () {
            // Lógica para cambiar de modo
          },
          icon: const Icon(Icons.wb_sunny_outlined),
        ),
        IconButton(
          onPressed: () {
            // Lógica para cambiar idioma
          },
          icon: const Icon(Icons.language),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}