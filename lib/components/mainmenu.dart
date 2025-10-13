// Archivo: lib/components/mainmenu.dart (ACTUALIZADO PARA FORZAR NAVEGACIÓN)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'dart:async'; 
import '../translations.dart'; 

class MainMenu extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;

  const MainMenu({
    super.key,
    required this.languageNotifier,
  });

  // ==========================================================
  // NAVEGACIÓN SUAVE UNIFICADA Y SEGURA (300ms)
  // ==========================================================
  Future<void> _navigateTo(BuildContext context, String route) async {
    if (route.isNotEmpty && context.mounted) {
      // 1. Forzar el desenfoque/cierre si hay un menú abierto.
      FocusManager.instance.primaryFocus?.unfocus();
      
      // 2. Mantenemos el retraso de 300ms, pero si el problema persiste,
      //    el siguiente paso es reducirlo a 0ms.
     // await Future.delayed(const Duration(milliseconds: 100)); 
      
      // 3. Navegar solo si el widget sigue montado después del delay.
      if (context.mounted) {
        // Ejecutar la navegación. Si esto no cambia la URL, el problema es en la app shell.
        context.go(route);
      }
    }
  }

  // ==========================================================
  // FUNCIÓN HELPER: Extrae subitems desde la estructura de nosotros
  // ==========================================================
  Map<String, String> _getAboutSubItems(Map<String, dynamic> translations) {
    return {
      (translations['our_mission'] as String? ?? 'Misión'): '/about#proposito',
      (translations['our_team'] as String? ?? 'Equipo'): '/about#enfoque',
      (translations['our_trajectory'] as String? ?? 'Trayectoria'): '/about#trayectoria',
    };
  }

  @override
  Widget build(BuildContext context) {
    
    final menuTextStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );
    
    final colorScheme = Theme.of(context).colorScheme;

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, _) {
        final translations = appTranslations[language] as Map<String, dynamic>? ?? {};
        
        final nosotrosSubItems = _getAboutSubItems(translations);
        
        return Row(
          children: [
            // 1. HOME
            _buildMenuItem(context, translations['home'] as String? ?? 'Inicio', '/', menuTextStyle),
            
            // 2. NOSOTROS (Mantiene el Dropdown)
            _buildDropdownMenuItem(
              context, 
              translations['about_us'] as String? ?? 'Nosotros', 
              '/about', 
              nosotrosSubItems, 
              menuTextStyle, 
              colorScheme,
            ),
            
            // 3. SERVICIOS (Enlace directo sin Dropdown)
            _buildMenuItem(context, translations['services'] as String? ?? 'Servicios', '/services', menuTextStyle),
            
            // 4. RESEARCH (ENLACE DIRECTO)
            _buildMenuItem(context, translations['research'] as String? ?? 'Investigación', '/research', menuTextStyle),
            
            // 5. CONTACTO (Botón Destacado)
            _buildContactButton(context, translations['contact'] as String? ?? 'Contacto', '/contact', menuTextStyle, colorScheme),
          ],
        );
      },
    );
  }

  // WIDGET _buildMenuItem (Enlace simple)
  Widget _buildMenuItem(BuildContext context, String title, String route, TextStyle style) {
    return TextButton(
      onPressed: () => _navigateTo(context, route),
      child: Text(title, style: style),
    );
  }

  // WIDGET _buildContactButton (Botón destacado)
  Widget _buildContactButton(BuildContext context, String title, String route, TextStyle style, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: TextButton(
        onPressed: () => _navigateTo(context, route),
        style: TextButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          title,
          style: style.copyWith(
            color: colorScheme.onPrimary, 
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // WIDGET _buildDropdownMenuItem (con chevron)
  // ==========================================================
  Widget _buildDropdownMenuItem(
    BuildContext context, 
    String title, 
    String route, 
    Map<String, String> subItems, 
    TextStyle style, 
    ColorScheme colorScheme
  ) {
    // Si no hay subItems, se convierte en un botón de navegación simple al Dropdown
    if (subItems.isEmpty) {
      return _buildMenuItem(context, title, route, style);
    }
    
    return TextButton(
      onPressed: () => _navigateTo(context, route), 
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Builder( 
        builder: (localContext) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: style),
                const SizedBox(width: 4),
                InkWell(
                  // Solo muestra el Popup si hay subItems (revisión de seguridad)
                  onTap: () {
                    if (subItems.isNotEmpty) {
                      _showPopupMenu(context, localContext, subItems, style, colorScheme);
                    }
                  },
                  child: const Icon(Icons.keyboard_arrow_down, size: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ... (resto de _showPopupMenu, que no se modificó)
  void _showPopupMenu(
    BuildContext rootContext, 
    BuildContext localContext, 
    Map<String, String> subItems, 
    TextStyle style, 
    ColorScheme colorScheme
  ) async {
    // 1. Calcular la posición exacta del widget para el menú
    if (!localContext.mounted) return;
    
    final RenderBox? renderBox = localContext.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    
    // 2. Definir la posición de showMenu para que aparezca DEBAJO del elemento.
    final RelativeRect rect = RelativeRect.fromLTRB(
      position.dx, 
      position.dy + size.height, 
      position.dx + size.width, 
      position.dy + size.height + 200, 
    );

    // 3. Mostrar el menú y esperar la selección.
    final String? selectedTitle = await showMenu<String>(
      context: localContext, 
      position: rect, 
      items: subItems.keys.map((String itemTitle) {
        return PopupMenuItem<String>(
          value: itemTitle, 
          child: Text(itemTitle, style: style.copyWith(fontWeight: FontWeight.normal)), 
        );
      }).toList(),
      surfaceTintColor: colorScheme.surfaceContainer,
      elevation: 4,
    );

    // 4. Navegación post-cierre
    if (selectedTitle != null) {
      final selectedRoute = subItems[selectedTitle];
      if (selectedRoute != null) {
        if (rootContext.mounted) { 
          _navigateTo(rootContext, selectedRoute);
        }
      }
    }
  }
}