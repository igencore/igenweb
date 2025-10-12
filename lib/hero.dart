// Archivo: lib/hero.dart

import 'package:flutter/material.dart';
import 'translations.dart';
import 'heroslider.dart'; 

class HeroSection extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;

  const HeroSection({super.key, required this.languageNotifier});

  // FUNCIÓN DE ACCIÓN: Se define aquí para ser llamada por los botones.
  void _handleButtonTap(BuildContext context) {
    // Aquí iría la lógica de navegación real a la sección de contacto o servicios.
    debugPrint("Botón 'Hero CTA' presionado. Navegando a la acción principal..."); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder<String>(
        valueListenable: languageNotifier,
        builder: (context, language, _) {
          final heroText = appTranslations[language]!;
          
          // PUNTO DE QUIEBRE AJUSTADO: Se convierte a móvil/tablet a 1000px
          final isDesktop = MediaQuery.of(context).size.width > 1000; 
          
          if (isDesktop) {
            // Se pasa el context al método de construcción
            return _buildDesktopHeroSection(context, heroText); 
          } else {
            // Se pasa el context al método de construcción
            return _buildMobileHeroSection(context, heroText);
          }
        },
      ),
    );
  }

  // MODIFICACIÓN: Ahora acepta BuildContext para usar _handleButtonTap
  Widget _buildDesktopHeroSection(BuildContext context, Map<String, dynamic> heroText) {
    const double cardHorizontalPadding = 32.0; 
    const double innerHorizontalPadding = 32.0; 

    return SizedBox(
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
                        heroText['hero_title'],
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        heroText['hero_subtitle'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      
                      // INICIO: Botón CTA para Desktop
                      const SizedBox(height: 32),
                      FilledButton(
                        onPressed: () => _handleButtonTap(context),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Theme.of(context).colorScheme.onPrimary, 
                        ),
                        child: Text(heroText['hero_button_text']),
                      ),
                      // FIN: Botón CTA para Desktop
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
    );
  }

  // MODIFICACIÓN: Ahora acepta BuildContext para usar _handleButtonTap
  Widget _buildMobileHeroSection(BuildContext context, Map<String, dynamic> heroText) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const SizedBox(
                height: 400,
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
                    heroText['hero_title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    heroText['hero_subtitle'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  
                  // INICIO: Botón CTA para Mobile
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => _handleButtonTap(context),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary, 
                    ),
                    child: Text(heroText['hero_button_text']),
                  ),
                  // FIN: Botón CTA para Mobile
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}