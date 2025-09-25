// Archivo: lib/translate.dart

import 'package:flutter/material.dart';

class LanguageToggle extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;

  const LanguageToggle({
    super.key,
    required this.languageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        languageNotifier.value = languageNotifier.value == 'EN' ? 'ES' : 'EN';
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: languageNotifier,
              builder: (context, language, _) {
                return Text(
                  language,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              },
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}