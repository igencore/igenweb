// Archivo: lib/research_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; 
import 'dart:async'; // Necesario para el slider

import 'translations.dart'; 

// Las imágenes de ejemplo deben estar en assets/images/research
const List<String> researchImages = [
  'assets/images/research_img_1.jpg',
  'assets/images/research_img_2.png',
  'assets/images/research_img_3.png',
];

class ResearchSection extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;

  const ResearchSection({
    super.key, 
    required this.languageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    // Definición de colores para la card de "jerarquía inferior"
    final colorScheme = Theme.of(context).colorScheme;
   // final isDarkMode = colorScheme.brightness == Brightness.dark;

    // Colores basados en el esquema monocromático
   // final cardBorderColor = isDarkMode ? Colors.white54 : Colors.black54;
   // final cardBackgroundColor = colorScheme.surfaceContainerLow; 

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, _) {
        final researchText = appTranslations[language]!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Container(
                decoration: BoxDecoration(
                 // color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                   border: Border.all(
                    color: colorScheme.primary,
                    width: 1.0, 
                  ), 
                
                ),
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    // Título principal de la sección
                    Text(
                      researchText['research_main_title'] ?? 'Investigación para la minería del mañana',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      researchText['research_main_subtitle'] ?? 'Conoce nuestra participación en el desarrollo tecnológico del futuro.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Contenido dividido en dos columnas (FadeSlider y Texto)
                    _ResearchContent(
                      languageNotifier: languageNotifier,
                      colorScheme: colorScheme,
                    ),
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

// Widget interno que contiene las dos columnas y maneja la adaptación
class _ResearchContent extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;
  final ColorScheme colorScheme;

  const _ResearchContent({
    required this.languageNotifier,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    // Contenido del texto
    final textContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32.0 : 0.0),
      child: ValueListenableBuilder<String>(
        valueListenable: languageNotifier,
        builder: (context, language, _) {
          final researchText = appTranslations[language]!;
          
          // Color de acento monocromático: onSurface con opacidad
      //    final monochromeAccent = colorScheme.onSurface.withAlpha(128);
          
          return Column(
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título (secundario)
              Text(
                researchText['research_content_title'] ?? 'Liderando la innovación en Minería 4.0',
                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary, 
                ),
              ),
              const SizedBox(height: 16),
              // Párrafo
              Text(
                researchText['research_content_body'] ?? 'Nuestro equipo se enfoca en la investigación de nuevos materiales, optimización de procesos y desarrollo de algoritmos de IA para mejorar la seguridad y la productividad de la minería a gran escala, con un enfoque en la sostenibilidad y el impacto ambiental.',
                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              // Botón de acción (ejemplo)
              OutlinedButton(
                onPressed: () {
                  debugPrint("Botón 'Ver Proyectos' presionado.");
                  // Aquí iría la navegación
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: BorderSide(color: colorScheme.primary, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                 // foregroundColor: monochromeAccent,
                ),
                child: Text(
                  researchText['research_content_button'] ?? 'Ver Proyectos',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Contenido del slider
    final sliderContent = FadeSliderCard(
      images: researchImages,
      colorScheme: colorScheme,
    );

    // Invertir el orden: Slider primero, Texto después
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: sliderContent), // Izquierda (Imágenes)
          Expanded(flex: 5, child: textContent),   // Derecha (Texto)
        ],
      );
    } else {
      // Orden apilado para móvil
      return Column(
        children: [
          sliderContent,
          const SizedBox(height: 40),
          textContent,
        ],
      );
    }
  }
}

// === WIDGET PARA LA ANIMACIÓN FADE IN / FADE OUT (Corregido: Transición Seamless y Duración) ===
class FadeSliderCard extends HookWidget {
  final List<String> images;
  final ColorScheme colorScheme;

  const FadeSliderCard({
    super.key,
    required this.images,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(color: colorScheme.surfaceContainerHighest),
      );
    }
    
    final currentImageIndex = useState(0); 
    final previousImageIndex = useState(0); 

    final fadeController = useAnimationController(
      duration: const Duration(milliseconds: 1500), 
    );

    useEffect(() {
      fadeController.forward(from: 0.0);
      
      // === CAMBIO CLAVE: Duración total del slide ajustada a 3 segundos ===
      final totalSlideDuration = const Duration(seconds: 3); 
      
      Timer? slideTimer;

      void startNextSlide() {
        slideTimer?.cancel(); 
        
        // Configuramos el nuevo timer
        slideTimer = Timer(totalSlideDuration, () {
          // Bloqueo de seguridad para evitar usar ValueNotifier después de dispose
          if (!context.mounted) {
             return;
          }

          previousImageIndex.value = currentImageIndex.value;
          currentImageIndex.value = (currentImageIndex.value + 1) % images.length;
          
          fadeController.forward(from: 0.0).then((_) {
            startNextSlide();
          });
        });
      }
      
      startNextSlide();

      // FUNCIÓN DE LIMPIEZA: esencial para evitar el error de ValueNotifier
      return () {
        slideTimer?.cancel();
      };
    }, [fadeController, images.length]);

    final animation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            // 1. IMAGEN ANTERIOR (Base, permanece visible sin animación de opacidad)
            Image.asset(
              images[previousImageIndex.value],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              key: ValueKey<int>(previousImageIndex.value), 
              errorBuilder: (context, error, stackTrace) => Container(color: colorScheme.surfaceContainerHighest),
            ),
            
            // 2. IMAGEN ACTUAL (Animación de opacidad 0.0 -> 1.0, se funde encima)
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Opacity(
                  opacity: animation.value,
                  child: Image.asset(
                    images[currentImageIndex.value],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    key: ValueKey<int>(currentImageIndex.value + 100), 
                    errorBuilder: (context, error, stackTrace) => Container(color: colorScheme.surfaceContainerHighest),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}