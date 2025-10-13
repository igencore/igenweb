// Archivo: lib/pages/home_page.dart (FINAL: SIN ERRORES Y FUNCIONAL)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import '../app_shell.dart'; 
import '../translations.dart'; 

// Importaciones de WIDGETS
import '../components/contact_section.dart';
import '../components/footer_section.dart';

// Importaciones de SECCIONES/PÁGINAS
import '../hero.dart';                
import '../logo_carousel.dart';       
import '../services_intro.dart';      
import '../research_section.dart';    


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  // Función declarada para el botón HERO
  void _heroButtonOnPressed(BuildContext context) {
    context.go('/about'); 
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = AppState.of(context).languageNotifier;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, child) {
        final translations = appTranslations[language] as Map<String, dynamic>? ?? {};
        final heroButtonText = translations['hero_button_text'] as String? ?? 'Ver Proyectos';
        
        return ColoredBox(
          color: backgroundColor,
          child: SingleChildScrollView( 
            child: Center(
              child: Column(
                children: [
                  
                  HeroSection(
                    translations: translations,
                    buttonText: heroButtonText,
                    onButtonPressed: () => _heroButtonOnPressed(context),
                  ), 
                  const SizedBox(height: 36), 
                  
                  const LogoCarousel(),
                  const SizedBox(height: 36), 
                  
                  // Pasa 'translations' a las secciones corregidas:
                  ServicesIntroSection(translations: translations), 
                  ResearchSection(translations: translations), 
                  
                  const SizedBox(height: 12),
                  
                  // ContactSection ahora es reactivo internamente
                  const ContactSection(), 
                  
                  const FooterSection(), 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}