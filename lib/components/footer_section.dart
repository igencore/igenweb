// Archivo: lib/components/footer_section.dart (FINAL: FOOTER RESPONSIVO)

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
        
        // --- DETECCIÓN DE PANTALLA ---
        final screenWidth = MediaQuery.of(context).size.width;
        // Usamos un breakpoint estándar (e.g., 700px)
        final bool isDesktop = screenWidth > 700; 
        
        // Obtenemos las traducciones basadas en el idioma actual
        final translations = appTranslations[language] as Map<String, dynamic>? ?? {}; 
        
        // Si las claves de footer no están en translations.dart (deberían estar)
        final copyrightText = translations['footer_copyright'] as String? ?? 'Todos los derechos reservados';
        final legalNoticeText = translations['footer_legal_notice'] as String? ?? 'Aviso Legal';

        // 1. Color de Fondo del Footer
        final Color backgroundColor = colorScheme.surfaceContainerLow; 
        
        // 2. Color de Texto/Contenido
        final Color contentColor = colorScheme.onSurfaceVariant; 
        
        // const double footerHeight = 80.0; // 🚨 ELIMINADO: La altura será dinámica
        const double contentMaxWidth = 1200.0;
        
        // Estilo base de texto
        final textStyle = TextStyle(
          fontSize: 14,
          color: contentColor,
        );
        
        // === ELEMENTOS ===
        // 1. Copyright Text
        final copyrightWidget = Text(
          '$copyrightText - 2025 iGenCore', 
          textAlign: TextAlign.center, // Centrado para móvil
          style: textStyle.copyWith(color: contentColor.withAlpha(128)),
        );

        // 2. Legal Notice Button
        final legalNoticeButton = TextButton(
          onPressed: () {
            // Lógica de navegación del aviso legal
            debugPrint("Navegando a Aviso Legal...");
          },
          style: TextButton.styleFrom(
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
        );
        // === FIN ELEMENTOS ===

        return Container(
          width: double.infinity, 
          // 🚨 ELIMINAMOS la altura fija y usamos padding para el espacio vertical
          color: backgroundColor, 
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // Agregado padding vertical
          
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: contentMaxWidth),
              
              // 🚨 CAMBIO CLAVE: Layout Responsivo
              child: isDesktop
                  ? Row( // DESKTOP: Lado a lado, justificado al espacio
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        copyrightWidget,
                        legalNoticeButton,
                      ],
                    )
                  : Column( // MÓVIL: Apilados y centrados
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        copyrightWidget,
                        const SizedBox(height: 10), // Espacio entre elementos
                        legalNoticeButton,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}