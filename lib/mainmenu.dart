// Archivo: lib/mainmenu.dart

import 'package:flutter/material.dart';
import 'translations.dart';

class MainMenu extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;

  const MainMenu({
    super.key,
    required this.languageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    // Estilo de texto unificado para los elementos del menú
    final menuTextStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, _) {
        final menuItems = appTranslations[language]!;
        
        if (isDesktop) {
          return Row(
            children: [
              _buildMenuItem(context, menuItems['home'], menuTextStyle),
              _buildDropdownMenuItem(context, menuItems['about_us'], [
                menuItems['our_mission'],
                menuItems['our_team'],
              ], menuTextStyle),
              _buildDropdownMenuItem(context, menuItems['services'], [
                menuItems['service_1'],
                menuItems['service_2'],
                menuItems['service_3'],
              ], menuTextStyle),
              _buildDropdownMenuItem(context, menuItems['research'], [
                menuItems['research_1'],
                menuItems['research_2'],
                menuItems['research_3'],
              ], menuTextStyle),
              _buildMenuItem(context, menuItems['contact'], menuTextStyle),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, TextStyle style) {
    return TextButton(
      onPressed: () {
        // Lógica de navegación
      },
      child: Text(title, style: style),
    );
  }

  Widget _buildDropdownMenuItem(BuildContext context, String title, List<String> subItems, TextStyle style) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 48),
      itemBuilder: (BuildContext context) {
        return subItems.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item, style: style),
          );
        }).toList();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(title, style: style),
            const Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
      ),
    );
  }
}