// Archivo: lib/drawer.dart (FINAL CON SERVICIOS Y ARTÍCULOS DINÁMICOS)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'translations.dart';
import 'app_shell.dart';

class CustomDrawer extends StatelessWidget {
  final Widget logoWidget; 

  const CustomDrawer({
    super.key,
    required this.logoWidget,
  });

  // ==========================================================
  // NAVEGACIÓN CENTRALIZADA: Cierra el Drawer y Navega
  // ==========================================================
  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Primero cierra el drawer
    if (route.isNotEmpty) {
      context.go(route); // Usamos context.go() para la navegación
    }
  }

  // ==========================================================
  // HELPER: Extrae subitems desde research_data
  // ==========================================================
  Map<String, String> _getResearchSubItems(Map<String, dynamic> translations) {
    final researchData = translations['research_data'] as List<dynamic>? ?? [];
    
    final Map<String, String> subItems = {};
    
    // Tomamos hasta 6 artículos para el menú móvil
    for (var item in researchData.take(6)) { 
      if (item is Map<String, dynamic>) {
        final title = item['title'] as String? ?? 'Artículo Desconocido'; 
        // Usamos la ruta completa del artículo (ej: /research/ia-flotacion)
        final route = item['route'] as String? ?? '/research'; 

        if (title != 'Artículo Desconocido') {
          subItems[title] = route;
        }
      }
    }
    return subItems;
  }

  // ==========================================================
  // 🚨 CORRECCIÓN: HELPER para servicios. Usa 'route' directo.
  // ==========================================================
  Map<String, String> _getServiceSubItems(Map<String, dynamic> translations) {
    final servicesData = translations['services_data'] as List<dynamic>? ?? [];
    
    final Map<String, String> subItems = {};
    
    // Tomamos la lista completa de servicios.
    for (var item in servicesData) { 
      if (item is Map<String, dynamic>) {
        final title = item['title'] as String? ?? 'Servicio Desconocido'; 
        // 🚨 CAMBIO CLAVE: Usamos 'route' que apunta a /services/nombre
        final route = item['route'] as String? ?? '/services'; 

        if (title != 'Servicio Desconocido') {
          // El enlace lleva a la ruta GoRouter anidada (ej: /services/geometalurgia)
          subItems[title] = route;
        }
      }
    }
    return subItems;
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final languageNotifier = appState.languageNotifier;
    final themeModeNotifier = appState.themeModeNotifier;

    final menuTextStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onSurface,
    );
    
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {

        final logoPath = (logoWidget as Image).image as AssetImage;

        final drawerLogoWidget = Image(
          image: logoPath,
          height: 20, 
        );
        
        final isDarkMode = themeMode == ThemeMode.dark;
        final drawerHeaderColor = isDarkMode 
          ? Theme.of(context).colorScheme.primaryContainer 
          : Theme.of(context).colorScheme.surfaceContainerHigh; 

        return Drawer(
          child: ValueListenableBuilder<String>(
            valueListenable: languageNotifier,
            builder: (context, language, _) {
              // Acceso seguro al mapa de traducciones
              final menuItems = appTranslations[language] as Map<String, dynamic>? ?? {}; 

              // Rellenar submenús dinámicos
              final researchSubItems = _getResearchSubItems(menuItems);
              final servicesSubItems = _getServiceSubItems(menuItems); // Servicios dinámicos

              // Submenú de Nosotros (Constante, usa hash/ancla)
              final aboutSubItems = {
                  (menuItems['our_mission'] as String? ?? 'Misión'): '/about#proposito',
                  (menuItems['our_team'] as String? ?? 'Equipo'): '/about#enfoque',
                  (menuItems['our_trajectory'] as String? ?? 'Trayectoria'): '/about#trayectoria',
              };

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: drawerHeaderColor,
                    ),
                    child: Center(child: drawerLogoWidget),
                  ),
                  // 1. HOME
                  _buildDrawerItem(context, menuItems['home'] as String? ?? 'Inicio', '/', menuTextStyle),
                  
                  // 2. NOSOTROS
                  _buildDrawerExpansionTile(
                    context, 
                    menuItems['about_us'] as String? ?? 'Nosotros', 
                    '/about', 
                    aboutSubItems,
                    menuTextStyle,
                  ),
                  
                  // 3. SERVICIOS (DINÁMICO)
                  _buildDrawerExpansionTile(
                    context, 
                    menuItems['services'] as String? ?? 'Servicios', 
                    '/services', 
                    servicesSubItems, // USA EL MAPA DE RUTAS COMPLETAS
                    menuTextStyle,
                  ),
                  
                  // 4. RESEARCH (DINÁMICO)
                  _buildDrawerExpansionTile(
                    context, 
                    menuItems['research'] as String? ?? 'Investigación', 
                    '/research', 
                    researchSubItems, 
                    menuTextStyle,
                  ),
                  
                  // 5. CONTACTO
                  _buildDrawerItem(context, menuItems['contact'] as String? ?? 'Contacto', '/contact', menuTextStyle),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // WIDGET _buildDrawerItem
  Widget _buildDrawerItem(BuildContext context, String title, String route, TextStyle style) {
    return ListTile(
      title: Text(title, style: style),
      onTap: () => _navigateTo(context, route), 
    );
  }

  // WIDGET _buildDrawerExpansionTile: Acepta un MAPA para subItems
  Widget _buildDrawerExpansionTile(BuildContext context, String title, String route, Map<String, String> subItems, TextStyle style) {
    // Si no hay subitems, funciona como un item simple
    if (subItems.isEmpty) {
        return _buildDrawerItem(context, title, route, style);
    }
      
    return ExpansionTile(
      title: GestureDetector(
        // Navega a la ruta principal al hacer clic en el título (ej: /services)
        onTap: () => _navigateTo(context, route),
        child: Text(title, style: style),
      ),
      children: subItems.entries.map((entry) {
        final itemTitle = entry.key;
        final itemRoute = entry.value;
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(itemTitle, style: style),
          ),
          onTap: () {
            // Navega a la ruta GoRouter del sub-ítem (ej: /services/geometalurgia)
            _navigateTo(context, itemRoute);
          },
        );
      }).toList(),
    );
  }
}