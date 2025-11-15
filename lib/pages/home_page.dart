// Archivo: lib/pages/home_page.dart (FINAL: SCROLL LISTENER CORREGIDO Y CONEXIÓN COMPLETA)

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
import '../publishings_section.dart';    


// 🚨 CONVERSIÓN A STATEFUL WIDGET
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 🚨 DECLARACIÓN DE ESTADO
  late ScrollController _scrollController;
  late ValueNotifier<bool> _isAnimationPausedNotifier; // Notificador para pasar a las animaciones
  
  // Función declarada para el botón HERO
  void _heroButtonOnPressed(BuildContext context) {
    context.go('/about'); 
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _isAnimationPausedNotifier = ValueNotifier(false); // false = no pausada (corriendo)

    // 🚨 AGREGAR LISTENER PARA PAUSAR AL INICIO DEL SCROLL
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // 🚨 CORRECCIÓN CLAVE: Pasamos la función _scrollListener para removerla.
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _isAnimationPausedNotifier.dispose();
    super.dispose();
  }
  
  // FUNCIÓN PARA PAUSAR LA ANIMACIÓN
  void _scrollListener() {
    // Si no está pausada, la pausamos inmediatamente.
    if (!_isAnimationPausedNotifier.value) {
      _isAnimationPausedNotifier.value = true;
    }
  }

  // FUNCIÓN PARA REANUDAR LA ANIMACIÓN (Se dispara al detenerse el scroll)
  bool _handleScrollEndNotification(ScrollEndNotification notification) {
    if (_isAnimationPausedNotifier.value) {
      // Retraso para asegurar que el usuario ha terminado.
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
           _isAnimationPausedNotifier.value = false;
        }
      });
    }
    return false;
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
          // 🚨 ENVOLVER EN NotificationListener PARA DETECTAR FIN DEL SCROLL
          child: NotificationListener<ScrollEndNotification>(
            onNotification: _handleScrollEndNotification,
            
            child: SingleChildScrollView( 
              // 🚨 ASIGNAR SCROLL CONTROLLER
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    
                    HeroSection(
                      translations: translations,
                      buttonText: heroButtonText,
                      onButtonPressed: () => _heroButtonOnPressed(context),
                    ), 
                    const SizedBox(height: 36), 
                    
                    // CONEXIÓN CLAVE: LogoCarousel
                    LogoCarousel(
                      isPausedNotifier: _isAnimationPausedNotifier,
                    ),
                    const SizedBox(height: 36), 
                    
                    // CONEXIÓN CORRECTA: ServicesIntroSection
                    ServicesIntroSection(
                      translations: translations,
                      isPausedNotifier: _isAnimationPausedNotifier,
                    ), 
                    
                    PublishingsSection(translations: translations), 
                    
                    const SizedBox(height: 12),
                    
                    const ContactSection(), 
                    
                    const FooterSection(), 
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}