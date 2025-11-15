// Archivo: lib/services_intro.dart (FINAL: BOTÓN MENOS RESALTADO)

import 'package:flutter/material.dart';
// 🚨 Importamos el componente de animación
import 'components/relief_point_cloud_animation.dart'; 
import 'package:go_router/go_router.dart';
// import 'translations.dart'; // Ya no es necesario importar aquí, se recibe el mapa

class ServicesIntroSection extends StatelessWidget {
  // 🚨 CAMBIO 1: Agregamos el parámetro de traducciones
  final Map<String, dynamic> translations;
  // 🚨 NUEVO: Parámetro para recibir el notificador de pausa
  final ValueNotifier<bool>? isPausedNotifier;

  const ServicesIntroSection({
    super.key,
    required this.translations, 
    this.isPausedNotifier, // 🚨 LO AÑADIMOS AL CONSTRUCTOR
  });

  void _handleServicesTap(BuildContext context) {
    context.go('/services');
    debugPrint("Navegando a la página de Servicios (/services)..."); 
  }

  @override
  Widget build(BuildContext context) {
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
                title, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, 
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle, 
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
                  // 🚨 PASAMOS EL NOTIFICADOR RECIBIDO
                  isPausedNotifier: isPausedNotifier, 
                ),
              ),
              
              const SizedBox(height: 24), 

              // BOTÓN DE SERVICIOS
              // 🚨 CAMBIO CLAVE: Usamos OutlinedButton en lugar de FilledButton.tonal
              OutlinedButton(
                onPressed: () => _handleServicesTap(context), 
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText, 
                  style: TextStyle( // Aseguramos que el texto use el color primario
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
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