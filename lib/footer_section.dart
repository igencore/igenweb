// Archivo: lib/footer_section.dart

import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  final ValueNotifier<String>? languageNotifier; 

  const FooterSection({super.key, this.languageNotifier});

  @override
  Widget build(BuildContext context) {
    // Obtenemos los colores del esquema
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    // 1. Color de Fondo del Footer: Usamos colorScheme.surface (Típicamente el color del AppBar/Navbar)
    final Color backgroundColor = colorScheme.surface; 
    
    // 2. Color de Texto/Contenido: Usamos onSurface (El color del texto sobre el fondo)
    final Color contentColor = colorScheme.onSurface;
    
    const double footerHeight = 80.0; 
    const double contentMaxWidth = 1200.0;
    
    // Estilo base de texto (ahora usa el color correcto para el fondo)
    final textStyle = TextStyle(
      fontSize: 14,
      color: contentColor, // Usamos onSurface (Negro en claro, Blanco en oscuro)
    );
    
    return Container(
      width: double.infinity, 
      height: footerHeight,
      color: backgroundColor, // Fondo surface (Oscuro en oscuro)
      padding: const EdgeInsets.symmetric(horizontal: 24.0), 
      
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: contentMaxWidth),
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Elemento Izquierdo: Copyright
              Text(
                '© 2024 iGenCore', 
                // Usamos contentColor (onSurface) con baja opacidad
                style: textStyle.copyWith(color: contentColor.withAlpha(128)), // 128 es opacidad media (0.5)
              ), 

              // 2. Elemento Derecho: Aviso Legal
              TextButton(
                onPressed: () {
                  // Lógica para links (ej: Privacidad)
                },
                child: Text('Aviso Legal', style: textStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}