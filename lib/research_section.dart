// Archivo: lib/research_section.dart (COMPLETO: RECIBE TRADUCCIONES Y NAVEGA)

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; 
import 'dart:async'; 
import 'package:go_router/go_router.dart'; // 🚨 AÑADIDO: Necesario para context.go()

// Las imágenes de ejemplo deben estar en assets/images/research
const List<String> researchImages = [
  'assets/images/research_img_1.jpg',
  'assets/images/research_img_2.png',
  'assets/images/research_img_3.png',
];

class ResearchSection extends StatelessWidget {
  // Ya recibe el mapa de traducciones correctamente.
  final Map<String, dynamic> translations;

  const ResearchSection({
    super.key,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos el mapa de traducciones directamente.
    final researchText = translations; 

    final isDesktop = MediaQuery.of(context).size.width > 900;
    final double verticalPadding = isDesktop ? 48.0 : 24.0;
    final double innerPadding = isDesktop ? 36.0 : 20.0;
    final colorScheme = Theme.of(context).colorScheme;

    // TÍTULOS Y SUBTÍTULOS USANDO EL MAPA RECIBIDO
    final mainTitle = researchText['research_main_title'] as String? ?? 'Investigación para la minería del mañana';
    final mainSubtitle = researchText['research_main_subtitle'] as String? ?? 'Conoce nuestra participación en el desarrollo tecnológico del futuro.';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding, 
        horizontal: 16.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
               border: Border.all(
                color: colorScheme.primary,
                width: 1.0, 
              ), 
            ),
            padding: EdgeInsets.all(innerPadding),
            child: Column(
              children: [
                // Título principal de la sección
                Text(
                  mainTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  mainSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 48),

                // Contenido dividido en dos columnas
                _ResearchContent(
                  researchText: researchText, 
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget interno que contiene las dos columnas y maneja la adaptación
class _ResearchContent extends StatelessWidget {
  final Map<String, dynamic> researchText; 
  final ColorScheme colorScheme;

  const _ResearchContent({
    required this.researchText,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
          
    // Títulos y textos usando el mapa recibido
    final contentTitle = researchText['research_content_title'] as String? ?? 'Liderando la innovación en Minería 4.0';
    final contentBody = researchText['research_content_body'] as String? ?? 'Nuestro equipo se enfoca en la investigación de nuevos materiales, optimización de procesos y desarrollo de algoritmos de IA para mejorar la seguridad y la productividad de la minería a gran escala, con un enfoque en la sostenibilidad y el impacto ambiental.';
    final contentButton = researchText['research_content_button'] as String? ?? 'Ver Proyectos';


    // Contenido del texto
    final textContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32.0 : 0.0),
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título (secundario)
          Text(
            contentTitle,
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
            contentBody,
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
              // 🚨 CORRECCIÓN FINAL: Implementación de la navegación del botón
              context.go('/research'); 
              debugPrint("Botón 'Ver Proyectos' presionado. Navegando a /research.");
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              side: BorderSide(color: colorScheme.primary, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              contentButton,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    // Contenido del slider
    final sliderContent = FadeSliderCard(
      images: researchImages,
      colorScheme: colorScheme,
    );

    // Lógica de Desktop/Mobile
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: sliderContent), 
          Expanded(flex: 5, child: textContent),   
        ],
      );
    } else {
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

// 🚨 FadeSliderCard se mantiene como HookWidget porque usa hooks y dart:async.
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
    // ... (El resto del código de FadeSliderCard se mantiene sin cambios)
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
      
      final totalSlideDuration = const Duration(seconds: 3); 
      
      Timer? slideTimer;

      void startNextSlide() {
        slideTimer?.cancel(); 
        
        slideTimer = Timer(totalSlideDuration, () {
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
            Image.asset(
              images[previousImageIndex.value],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              key: ValueKey<int>(previousImageIndex.value), 
              errorBuilder: (context, error, stackTrace) => Container(color: colorScheme.surfaceContainerHighest),
            ),
            
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