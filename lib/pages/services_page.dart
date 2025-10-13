// Archivo: lib/pages/services_page.dart (FINAL - CON ANIMACIÓN Y ESTRUCTURA LIMPIA)

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // 🚨 NUEVO: Necesario para HookBuilder
import 'package:go_router/go_router.dart';
import '../app_shell.dart'; 
import '../components/footer_section.dart';
import '../translations.dart'; 
// 🚨 NUEVO: Importamos el componente de animación centralizado
import '../components/relief_point_cloud_animation.dart'; 

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  // ====================================================================
  // FUNCIÓN HELPER: Convierte String a IconData (Sin cambios)
  // ====================================================================
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'precision_manufacturing': return Icons.precision_manufacturing; // Geometalurgia
      case 'waves_outlined': return Icons.waves_outlined;                 // Transporte de Fluidos
      case 'memory_outlined': return Icons.memory_outlined;               // Automatización de Procesos
      case 'handyman_outlined': return Icons.handyman_outlined;           // Metalmecánica
      case 'insights': return Icons.insights;                             // Flotación Avanzada
      case 'texture': return Icons.texture;                               // Modelamiento de Arcillas
      case 'science': return Icons.science;                               // Análisis de Reactivos
      case 'settings_suggest': return Icons.settings_suggest;             // Lubricación Automática
      case 'leak_add': return Icons.leak_add;                             // Monitoreo Remoto / Pigging
      default: return Icons.category; 
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
            
            final serviceData = translations['services_data'] as List<dynamic>? ?? [];
            final contactCta = translations['contact_us_cta'] as String? ?? 'Contact us';

            return Column(
              children: [
                 const SizedBox(height: 40),
                // 2. HEADER (TÍTULO PRINCIPAL)
                _buildHeader(context, translations, colorScheme),

                // 🚨 1. ANIMACIÓN DE NUBE DE PUNTOS (NUEVO)
                HookBuilder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: Center(
                        child: RepaintBoundary(
                          child: ReliefPointCloudAnimation(
                            themeModeNotifier: ValueNotifier(Theme.of(context).brightness == Brightness.dark 
                              ? ThemeMode.dark 
                              : ThemeMode.light),
                          ),
                        ),
                      ),
                    );
                  }
                ),
                
                // 3. LISTADO DE SERVICIOS (RESPONSIVO: Grid para Desktop, Lista para Móvil)
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: isDesktop
                      ? _buildDesktopGrid(context, serviceData, colorScheme, contactCta)
                      : _buildMobileList(context, serviceData, colorScheme, contactCta),
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
  // WIDGETS AUXILIARES (sin cambios en la lógica)
  // ====================================================================

  Widget _buildHeader(BuildContext context, Map<String, dynamic> translations, ColorScheme colorScheme) {
    // 🚨 NOTA: Se ajusta el padding vertical del header ahora que la animación está arriba.
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), 
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            translations['services_intro_title'] as String? ?? 'Nuestros Servicios',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            translations['services_intro_subtitle'] as String? ?? 'Aquí irá el detalle de la oferta de consultoría y soluciones de iGenCore para el sector minero.',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Diseño para ESCRITORIO (Grid de 3 columnas)
  Widget _buildDesktopGrid(BuildContext context, List<dynamic> services, ColorScheme colorScheme, String contactCta) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.0, 
      ),
      itemBuilder: (context, index) {
        final service = services[index] as Map<String, dynamic>?;
        if (service == null) return const SizedBox.shrink();

        return _ServiceCard(
          title: service['title'] as String? ?? 'Servicio Desconocido',
          summary: service['summary'] as String? ?? 'Descripción no disponible.',
          route: service['route'] as String? ?? '/services',
          iconData: _getIconData(service['icon'] as String? ?? 'category'), 
          colorScheme: colorScheme,
          contactCta: contactCta,
        );
      },
    );
  }

  // Diseño para MÓVIL (Lista vertical)
  Widget _buildMobileList(BuildContext context, List<dynamic> services, ColorScheme colorScheme, String contactCta) {
    return Column(
      children: services.map((service) {
        final serviceMap = service as Map<String, dynamic>?;
        if (serviceMap == null) return const SizedBox.shrink();
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _ServiceCard(
            title: serviceMap['title'] as String? ?? 'Servicio Desconocido',
            summary: serviceMap['summary'] as String? ?? 'Descripción no disponible.',
            route: serviceMap['route'] as String? ?? '/services',
            iconData: _getIconData(serviceMap['icon'] as String? ?? 'category'), 
            colorScheme: colorScheme,
            contactCta: contactCta,
          ),
        );
      }).toList(),
    );
  }
}

// ====================================================================
// WIDGET PRIVADO PARA LA TARJETA DE CADA SERVICIO (Sin cambios)
// ====================================================================

class _ServiceCard extends StatelessWidget {
  final String title;
  final String summary;
  final String route;
  final IconData iconData;
  final ColorScheme colorScheme;
  final String contactCta;

  const _ServiceCard({
    required this.title,
    required this.summary,
    required this.route,
    required this.iconData,
    required this.colorScheme,
    required this.contactCta,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (context.mounted) context.go(route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(
                    iconData,
                    size: 50, 
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    summary,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              
              // Botón de Contacto
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FilledButton.icon(
                  onPressed: () {
                    // Navega a la página de contacto
                    if (context.mounted) context.go('/contact');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(contactCta),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}