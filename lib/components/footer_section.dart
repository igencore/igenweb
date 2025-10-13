// Archivo: lib/components/footer_section.dart (FINAL: TRADUCCIÓN REACTIVA)

import 'package:flutter/material.dart';
import '../translations.dart'; 
import '../app_shell.dart'; // 🚨 IMPORTADO: Necesario para acceder a AppState

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 🚨 ACCESO AL NOTIFICADOR DE IDIOMA
    final languageNotifier = AppState.of(context).languageNotifier; 
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    // 🚨 ENVOLVEMOS EN ValueListenableBuilder para la reactividad
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, child) {
        
        // Obtenemos las traducciones basadas en el idioma actual
        final translations = appTranslations[language] as Map<String, dynamic>? ?? {}; 
        
        // Si las claves de footer no están en translations.dart (deberían estar)
        final copyrightText = translations['footer_copyright'] as String? ?? 'Todos los derechos reservados';
        final legalNoticeText = translations['footer_legal_notice'] as String? ?? 'Aviso Legal';

        // 1. Color de Fondo del Footer
        final Color backgroundColor = colorScheme.surfaceContainerLow; 
        
        // 2. Color de Texto/Contenido
        final Color contentColor = colorScheme.onSurfaceVariant; // Usamos un color secundario para el footer
        
        const double footerHeight = 80.0; 
        const double contentMaxWidth = 1200.0;
        
        // Estilo base de texto
        final textStyle = TextStyle(
          fontSize: 14,
          color: contentColor,
        );
        
        return Container(
          width: double.infinity, 
          height: footerHeight,
          color: backgroundColor, 
          padding: const EdgeInsets.symmetric(horizontal: 24.0), 
          
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: contentMaxWidth),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Elemento Izquierdo: Copyright (Traducción + año)
                  Text(
                    '$copyrightText - 2025 iGenCore', 
                    style: textStyle.copyWith(color: contentColor.withAlpha(128)),
                  ), 

                  // 2. Elemento Derecho: Aviso Legal (Botón con fondo suave)
                  TextButton(
                    onPressed: () {
                      // Lógica de navegación del aviso legal
                      debugPrint("Navegando a Aviso Legal...");
                    },
                    style: TextButton.styleFrom(
                      // Usamos un color que se vea en el fondo surfaceContainerLow
                      backgroundColor: colorScheme.surfaceContainerHigh.withAlpha(80), 
                      foregroundColor: contentColor, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size.zero, 
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      legalNoticeText, 
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: contentColor, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}