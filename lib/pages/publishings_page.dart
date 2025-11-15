// Archivo: lib/pages/publishings_page.dart (FINAL CON IMAGEN INTRODUCTORIA)

import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart'; <-- Necesario para los enlaces
import '../app_shell.dart'; 
import '../components/footer_section.dart';
import '../translations.dart'; 

// ==========================================================
// 🚨 CAMBIO 1: Nombre de la lista de imágenes
// ==========================================================
const List<String> publishingsImages = [
  'assets/images/publishings_img_1.jpg', // 🚨 Actualiza las rutas de tus assets si cambian de nombre
  'assets/images/publishings_img_2.png',
  'assets/images/publishings_img_3.png',
];

class PublishingsPage extends StatelessWidget {
  const PublishingsPage({super.key});

  // ====================================================================
  // FUNCIÓN HELPER: Convierte String a IconData (Sin cambios)
  // ====================================================================
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'science': return Icons.science;
      case 'insights': return Icons.insights;
      case 'psychology': return Icons.psychology;
      case 'memory_outlined': return Icons.memory_outlined;
      default: return Icons.article; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = AppState.of(context).languageNotifier;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        
        child: ValueListenableBuilder<String>(
          valueListenable: languageNotifier,
          builder: (context, language, child) {
            final translations = appTranslations[language] as Map<String, dynamic>? ?? {};
            
            // 🚨 CAMBIO 2: Acceder a 'publishings_data' y 'publishings_read_more_cta'
            final publishingsData = translations['publishings_data'] as List<dynamic>? ?? [];
            final readMoreCta = translations['publishings_read_more_cta'] as String? ?? 'Read Article';

            return Column(
              children: [
                // 1. IMAGEN INTRODUCTORIA
                _buildIntroductoryImage(context, translations, colorScheme), 
                
                // 2. HEADER (Bajada de texto)
                _buildHeader(context, translations, colorScheme),
                
                // 3. LISTADO DE ARTÍCULOS
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: isDesktop
                      // 🚨 CAMBIO 3: Pasar 'publishingsData' a las funciones de construcción
                      ? _buildDesktopGrid(context, publishingsData, colorScheme, readMoreCta)
                      : _buildMobileList(context, publishingsData, colorScheme, readMoreCta),
                ),
                
                const SizedBox(height: 40),
                
                // 4. FOOTER
                const FooterSection(),
              ],
            );
          },
        ),
      ),
    );
  }
  
  // ====================================================================
  // WIDGET INTRODUCTORIO
  // ====================================================================
  Widget _buildIntroductoryImage(BuildContext context, Map<String, dynamic> translations, ColorScheme colorScheme) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    // 🚨 CAMBIO 4: Texto del Hero actualizado
    final heroTitle = translations['publishings_intro_title'] as String? ?? 'Publicaciones Recientes';
    
    // 🚨 CAMBIO 5: Usar la lista de imágenes 'publishingsImages'
    final String imageUrl = publishingsImages.isNotEmpty 
      ? publishingsImages[0] 
      : 'assets/images/default_publishings_placeholder.jpg'; 

    return Container(
      width: double.infinity,
      height: isDesktop ? 350 : 250, 
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Container(
        color: Colors.black.withAlpha(102), // 102/255 ≈ 0.4
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            heroTitle, 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.w900,
              shadows: [
                Shadow(
                  blurRadius: 12.0, 
                  color: Colors.black.withAlpha(204), // 204/255 ≈ 0.8
                  offset: const Offset(0, 4), 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // ====================================================================
  // WIDGETS AUXILIARES
  // ====================================================================

  Widget _buildHeader(BuildContext context, Map<String, dynamic> translations, ColorScheme colorScheme) {
    // 🚨 CAMBIO 6: Texto del subtítulo actualizado
    final subtitle = translations['publishings_intro_subtitle'] as String? ?? 'Compartimos nuestras conclusiones y conocimientos relevantes para la industria.';
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      constraints: const BoxConstraints(maxWidth: 900), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  // 🚨 CAMBIO 7: Uso de _PublishingCard
  Widget _buildDesktopGrid(BuildContext context, List<dynamic> articles, ColorScheme colorScheme, String readMoreCta) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final article = articles[index] as Map<String, dynamic>?;
        if (article == null) return const SizedBox.shrink();

        return _PublishingCard(
          title: article['title'] as String? ?? 'Artículo Desconocido',
          summary: article['summary'] as String? ?? 'Resumen no disponible.',
          route: article['route'] as String? ?? '/publishings', // 🚨 Ruta por defecto
          iconData: _getIconData(article['icon'] as String? ?? 'article'), 
          colorScheme: colorScheme,
          readMoreCta: readMoreCta,
        );
      },
    );
  }

  // 🚨 CAMBIO 8: Uso de _PublishingCard
  Widget _buildMobileList(BuildContext context, List<dynamic> articles, ColorScheme colorScheme, String readMoreCta) {
    return Column(
      children: articles.map((article) {
        final articleMap = article as Map<String, dynamic>?;
        if (articleMap == null) return const SizedBox.shrink();
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _PublishingCard(
            title: articleMap['title'] as String? ?? 'Artículo Desconocido',
            summary: articleMap['summary'] as String? ?? 'Resumen no disponible.',
            route: articleMap['route'] as String? ?? '/publishings', // 🚨 Ruta por defecto
            iconData: _getIconData(articleMap['icon'] as String? ?? 'article'), 
            colorScheme: colorScheme,
            readMoreCta: readMoreCta,
          ),
        );
      }).toList(),
    );
  }
}

// ====================================================================
// 🚨 CAMBIO 9: Renombrar la clase privada
// ====================================================================
class _PublishingCard extends StatelessWidget {
  final String title;
  final String summary;
  final String route;
  final IconData iconData;
  final ColorScheme colorScheme;
  final String readMoreCta;

  const _PublishingCard({
    required this.title,
    required this.summary,
    required this.route,
    required this.iconData,
    required this.colorScheme,
    required this.readMoreCta,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // if (context.mounted) context.go(route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  iconData,
                  size: 40, 
                  color: colorScheme.secondary,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          summary,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.4,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextButton.icon(
                        // Se mantiene deshabilitado para desarrollo
                        onPressed: null, 
                        
                        icon: const Icon(Icons.chevron_right),
                        label: Text(readMoreCta),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.primary, 
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        ),
                      ),
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