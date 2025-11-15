// Archivo: lib/hero.dart (ACTUALIZADO CON RELLENO EXTERIOR Y BOTÓN CORREGIDO)

import 'package:flutter/material.dart';

import 'heroslider.dart'; // Importación de HeroSlider

class HeroSection extends StatelessWidget {
  // Parámetros necesarios para la traducción y la acción
  final Map<String, dynamic> translations;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const HeroSection({
    super.key,
    required this.translations,
    required this.buttonText,
    required this.onButtonPressed,
  }); 
  
  // 🚀 CONSTANTE AÑADIDA: Relleno exterior para separar la Card del borde.
  static const double externalPadding = 24.0; 

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000; 
    
    if (isDesktop) {
      return _buildDesktopHeroSection(context); 
    } else {
      return _buildMobileHeroSection(context);
    }
  }

  // ==========================================================
  // SECCIÓN DE ESCRITORIO (ACTUALIZADA con Botón Corregido)
  // ==========================================================
  Widget _buildDesktopHeroSection(BuildContext context) {
    const double cardHorizontalPadding = 32.0; 
    const double innerHorizontalPadding = 32.0; 

    final title = translations['hero_title'] as String? ?? 'Innovación Operacional'; 
    final subtitle = translations['hero_subtitle'] as String? ?? 'Soluciones integrales de excelencia.'; 

    // ➡️ ENVOLVEMOS la SizedBox (que contiene la Card) en Padding
    return Padding(
      padding: const EdgeInsets.all(externalPadding),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(cardHorizontalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: innerHorizontalPadding, vertical: 64.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title, 
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          subtitle, 
                          style: const TextStyle(fontSize: 20),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // 🚨 CORRECCIÓN 1: Cambiado a ElevatedButton
                        // 🚨 CORRECCIÓN 2: Eliminado el style local para usar el tema Amarillo/Negro
                        ElevatedButton(
                          onPressed: onButtonPressed, 
                          // ⚠️ ¡Eliminado el style: FilledButton.styleFrom(...)!
                          child: Text(buttonText), 
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: innerHorizontalPadding),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const SizedBox(
                          height: 400,
                          child: HeroSlider(), 
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SECCIÓN MÓVIL (ACTUALIZADA con Botón Corregido)
  // ==========================================================
  Widget _buildMobileHeroSection(BuildContext context) {
    
    final title = translations['hero_title'] as String? ?? 'Innovación Operacional'; 
    final subtitle = translations['hero_subtitle'] as String? ?? 'Soluciones integrales de excelencia.'; 
    
    // ➡️ ENVOLVEMOS la Card en Padding
    return Padding(
      padding: const EdgeInsets.all(externalPadding),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(
                  child: HeroSlider(), 
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title, 
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle, 
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // 🚨 CORRECCIÓN 1: Cambiado a ElevatedButton
                    // 🚨 CORRECCIÓN 2: Eliminado el style local para usar el tema Amarillo/Negro
                    ElevatedButton(
                      onPressed: onButtonPressed,
                      // ⚠️ ¡Eliminado el style: FilledButton.styleFrom(...)!
                      child: Text(buttonText), 
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}