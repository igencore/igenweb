// Archivo: lib/themetoggle.dart

import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const ThemeToggle({
    super.key,
    required this.themeModeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
      },
      icon: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeModeNotifier,
        builder: (context, themeMode, _) {
          return Icon(
            themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
          );
        },
      ),
    );
  }
}