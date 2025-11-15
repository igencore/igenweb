// Archivo: lib/pages/services_page.dart (FINAL - CON PAUSA DE ANIMACIÓN AL HACER SCROLL)

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../app_shell.dart'; 
import '../components/footer_section.dart';
import '../translations.dart'; 
// 🚨 NUEVO: Importamos el componente de animación centralizado
import '../components/relief_point_cloud_animation.dart'; 

// 🚨 1. CONVERSIÓN A STATEFUL WIDGET
class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});
  
  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  // 🚨 2. DECLARACIÓN DE ESTADO PARA SCROLL Y PAUSA
  late ScrollController _scrollController;
  late ValueNotifier<bool> _isAnimationPausedNotifier;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _isAnimationPausedNotifier = ValueNotifier(false); // false = no pausada (corriendo)

    // 🚨 3. AGREGAR LISTENER PARA PAUSAR AL INICIO DEL SCROLL
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _isAnimationPausedNotifier.dispose();
    super.dispose();
  }
  
  // FUNCIÓN PARA PAUSAR LA ANIMACIÓN (MISMA LÓGICA DE home_page.dart)
  void _scrollListener() {
    // Si la animación no está pausada, la pausamos inmediatamente.
    if (!_isAnimationPausedNotifier.value) {
      _isAnimationPausedNotifier.value = true;
    }
  }

  // FUNCIÓN PARA REANUDAR LA ANIMACIÓN (MISMA LÓGICA DE home_page.dart)
  bool _handleScrollEndNotification(ScrollEndNotification notification) {
    if (_isAnimationPausedNotifier.value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
           _isAnimationPausedNotifier.value = false;
        }
      });
    }
    return false;
  }


  // ====================================================================
  // FUNCIÓN HELPER: Convierte String a IconData (Sin cambios)
  // ====================================================================
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'precision_manufacturing': return Icons.precision_manufacturing;
      case 'waves_outlined': return Icons.waves_outlined;
      case 'memory_outlined': return Icons.memory_outlined;
      case 'handyman_outlined': return Icons.handyman_outlined;
      case 'insights': return Icons.insights;
      case 'texture': return Icons.texture;
      case 'science': return Icons.science;
      case 'settings_suggest': return Icons.settings_suggest;
      case 'leak_add': return Icons.leak_add;
      default: return Icons.category; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = AppState.of(context).languageNotifier;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;

    // 🚨 4. ENVOLVER EN NotificationListener
    return NotificationListener<ScrollEndNotification>(
      onNotification: _handleScrollEndNotification,
      
      child: SingleChildScrollView(
        // 🚨 5. ASIGNAR SCROLL CONTROLLER
        controller: _scrollController,
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

                  // 🚨 1. ANIMACIÓN DE NUBE DE PUNTOS
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
                              // 🚨 6. PASAR EL NOTIFICADOR DE PAUSA
                              isPausedNotifier: _isAnimationPausedNotifier,
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
      ),
    );
  }
  
  // ... (El resto de los métodos auxiliares: _buildHeader, _buildDesktopGrid, _buildMobileList)
  
  Widget _buildHeader(BuildContext context, Map<String, dynamic> translations, ColorScheme colorScheme) {
    // ... (sin cambios)
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
        childAspectRatio: 0.53, // Mantenido a petición del usuario.
      ),
      itemBuilder: (context, index) {
        final service = services[index] as Map<String, dynamic>?;
        if (service == null) return const SizedBox.shrink();
        
        // 🚨 CÁLCULO DE LA CLASE ESPECIAL
        final serviceId = service['id'] as String? ?? (index + 1).toString();
        final isSubcategory = serviceId.contains(RegExp(r'[a-z]')); 

        return _ServiceCard(
          title: service['title'] as String? ?? 'Servicio Desconocido',
          summary: service['summary'] as String? ?? 'Descripción no disponible.',
          route: service['route'] as String? ?? '/services',
          iconData: _getIconData(service['icon'] as String? ?? 'category'), 
          colorScheme: colorScheme,
          contactCta: contactCta,
          serviceId: serviceId, // 🚨 PASAMOS EL ID
          isSubcategoryCard: isSubcategory, // 🚨 PASAMOS LA CLASE/ESTADO
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
        
        // 🚨 CÁLCULO DE LA CLASE ESPECIAL
        final serviceId = serviceMap['id'] as String? ?? '0';
        final isSubcategory = serviceId.contains(RegExp(r'[a-z]')); 
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _ServiceCard(
            title: serviceMap['title'] as String? ?? 'Servicio Desconocido',
            summary: serviceMap['summary'] as String? ?? 'Descripción no disponible.',
            route: serviceMap['route'] as String? ?? '/services',
            iconData: _getIconData(serviceMap['icon'] as String? ?? 'category'), 
            colorScheme: colorScheme,
            contactCta: contactCta,
            serviceId: serviceId, // 🚨 PASAMOS EL ID
            isSubcategoryCard: isSubcategory, // 🚨 PASAMOS LA CLASE/ESTADO
          ),
        );
      }).toList(),
    );
  }
}

// ====================================================================
// WIDGET PRIVADO PARA LA TARJETA DE CADA SERVICIO (SIN CAMBIOS)
// ====================================================================

class _ServiceCard extends StatelessWidget {
  final String title;
  final String summary;
  final String route;
  final IconData iconData;
  final ColorScheme colorScheme;
  final String contactCta;
  final String serviceId; 
  final bool isSubcategoryCard; 

  const _ServiceCard({
    required this.title,
    required this.summary,
    required this.route,
    required this.iconData,
    required this.colorScheme,
    required this.contactCta,
    required this.serviceId, 
    required this.isSubcategoryCard, 
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isSubcategory = isSubcategoryCard; 
    final double elevation = isSubcategory ? 3 : 6;
    
    final Color cardColor;
    
    if (isDarkMode) {
      cardColor = isSubcategory 
          ? colorScheme.surfaceContainerHigh 
          : Theme.of(context).cardColor;
    } else {
      cardColor = isSubcategory
          ? colorScheme.surfaceContainerLow 
          : Theme.of(context).cardColor;     
    }

    final Color iconColor = isSubcategory 
        ? colorScheme.onSurfaceVariant 
        : colorScheme.primary;

    return Card(
      elevation: elevation,
      color: cardColor, 
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
                    color: iconColor, 
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$serviceId. $title',
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
                    maxLines: 30, 
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (context.mounted) context.go('/contact');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Más información"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}