// Archivo: lib/publishings_section.dart (TÍTULO PRINCIPAL CON MAYOR CONTRASTE)

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; 
import 'dart:async'; 
import 'package:go_router/go_router.dart';

// Las imágenes de ejemplo deben estar en assets/images/publishings
const List<String> publishingsImages = [
  'assets/images/publishings_img_1.jpg',
  'assets/images/publishings_img_2.png',
  'assets/images/publishings_img_3.png',
];

class PublishingsSection extends StatelessWidget {
  final Map<String, dynamic> translations;

  const PublishingsSection({
    super.key,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    final publishingsText = translations; 
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final double verticalPadding = isDesktop ? 48.0 : 24.0;
    final double innerPadding = isDesktop ? 36.0 : 20.0;
    final colorScheme = Theme.of(context).colorScheme;

    final mainTitle = publishingsText['publishings_main_title'] as String? ?? 'Publicaciones para la minería del mañana';
    final mainSubtitle = publishingsText['publishings_main_subtitle'] as String? ?? 'Conoce nuestra participación en el desarrollo tecnológico del futuro.';

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
                    // 🚨 CAMBIO CLAVE: Usamos colorScheme.primary para el acento y contraste
                    color: colorScheme.primary,
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
                _PublishingsContent( 
                  publishingsText: publishingsText, 
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
class _PublishingsContent extends StatelessWidget {
// ... (código interno _PublishingsContent y FadeSliderCard sin cambios)
  final Map<String, dynamic> publishingsText; 
  final ColorScheme colorScheme;

  const _PublishingsContent({
    required this.publishingsText,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
          
    final contentTitle = publishingsText['publishings_content_title'] as String? ?? 'Liderando la innovación en Minería 4.0';
    final contentBody = publishingsText['publishings_content_body'] as String? ?? 'Nuestro equipo se enfoca en la investigación de nuevos materiales, optimización de procesos y desarrollo de algoritmos de IA para mejorar la seguridad y la productividad de la minería a gran escala, con un enfoque en la sostenibilidad y el impacto ambiental.';
    final contentButton = publishingsText['publishings_content_button'] as String? ?? 'Ver Publicaciones';

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
          
          // 🚨 CORRECCIÓN 1: Cambiado a ElevatedButton para heredar el tema Amarillo/Negro
          ElevatedButton(
            onPressed: () {
              context.go('/publishings'); 
              debugPrint("Botón 'Ver Publicaciones' presionado. Navegando a /publishings.");
            },
            // 🚨 CORRECCIÓN 2: Se ELIMINA el bloque style local para heredar el tema global
            // Las propiedades de padding, shape y color ya están definidas en theme.dart
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
      images: publishingsImages,
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

// 🚨 FadeSliderCard se mantiene como HookWidget (Sin cambios necesarios)
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