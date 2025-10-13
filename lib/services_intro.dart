// Archivo: lib/services_intro.dart (CORREGIDO PARA RECIBIR Y USAR TRADUCCIONES)

import 'package:flutter/material.dart';
// 🚨 Importamos el componente de animación
import 'components/relief_point_cloud_animation.dart'; 
import 'package:go_router/go_router.dart';
// import 'translations.dart'; // Ya no es necesario importar aquí, se recibe el mapa

class ServicesIntroSection extends StatelessWidget {
  // 🚨 CAMBIO 1: Agregamos el parámetro de traducciones
  final Map<String, dynamic> translations;

  const ServicesIntroSection({
    super.key,
    required this.translations, // Lo hacemos requerido para la consistencia con HomePage
  });

  void _handleServicesTap(BuildContext context) {
    context.go('/services');
    debugPrint("Navegando a la página de Servicios (/services)..."); 
  }

  // 🚨 CAMBIO 2: Eliminamos el helper temporal de idioma.

  @override
  Widget build(BuildContext context) {
    // 🚨 CAMBIO 3: Usamos directamente el mapa de traducciones
    final title = translations['services_intro_title'] as String? ?? 'Nuestros Servicios';
    final subtitle = translations['services_intro_subtitle'] as String? ?? 'Descubre cómo podemos ayudarte.';
    final buttonText = translations['contact_us_cta'] as String? ?? 'Solicitar Asesoría';
    
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800), 
          child: Column(
            children: [
              Text(
                title, // Usamos la variable traducida
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, 
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle, // Usamos la variable traducida
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: colorScheme.onSurface.withAlpha(179),
                ),
              ),
              const SizedBox(height: 48),
              
              // 🚨 USO DEL COMPONENTE CENTRALIZADO
              RepaintBoundary( 
                child: ReliefPointCloudAnimation(
                  themeModeNotifier: ValueNotifier(Theme.of(context).brightness == Brightness.dark 
                    ? ThemeMode.dark 
                    : ThemeMode.light),
                ),
              ),
              
              const SizedBox(height: 24), 

              // BOTÓN DE SERVICIOS
              FilledButton.tonal(
                onPressed: () => _handleServicesTap(context), 
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText, // Usamos la variable traducida
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
// 🚨 NOTA: Se asume que ReliefPointCloudAnimation y ReliefPainter existen en otro archivo.