// Archivo: lib/main.dart (VERSIÓN FINAL CON TEMAS PERSONALIZADOS Y SCROLL FIX)

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart'; 
import 'package:flutter_web_plugins/flutter_web_plugins.dart'; 
// 🚨 Nuevo: Necesario para PointerDeviceKind
import 'package:flutter/gestures.dart'; 

// 🚨 IMPORTACIÓN AÑADIDA DEL TEMA PERSONALIZADO
import 'theme.dart'; 

// ==========================================================
// 1. Importaciones de Páginas y Shell
// ==========================================================
import 'pages/home_page.dart'; 
import 'pages/about_page.dart'; 
import 'pages/services_page.dart'; 
import 'pages/contact_page.dart'; 
import 'pages/publishings_page.dart'; 
import 'app_shell.dart'; 

// ==========================================================
// 2. CORRECCIÓN DE SCROLL POR ARRASTRE (Para Web/Desktop Táctil)
// ==========================================================

// 🚨 Define un ScrollBehavior personalizado para forzar el scroll por arrastre
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    // Habilita el desplazamiento por ratón y tacto en todas las plataformas
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.touch,
  };
}

// ==========================================================
// PUNTO DE ENTRADA PRINCIPAL
// ==========================================================
void main() {
  if (kIsWeb) {
    // Usar la estrategia de URL con Hash (#) para compatibilidad con hosting estático
    setUrlStrategy(const HashUrlStrategy());
  }
  runApp(const IgenCoreApp());
}

class IgenCoreApp extends StatefulWidget {
  const IgenCoreApp({super.key});

  @override
  State<IgenCoreApp> createState() => _IgenCoreAppState();
}

class _IgenCoreAppState extends State<IgenCoreApp> {
  // Los ValueNotifier que serán inyectados globalmente
  late final ValueNotifier<ThemeMode> _themeMode;
  late final ValueNotifier<String> _language;
  late final GoRouter _router; 

  @override
  void initState() {
    super.initState();
    _themeMode = ValueNotifier(ThemeMode.light);
    _language = ValueNotifier('ES');
    
    // DEFINICIÓN DEL ROUTER
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            // AppState envuelve la AppShell e inyecta los ValueNotifier.
            return AppState(
              themeModeNotifier: _themeMode,
              languageNotifier: _language,
              child: AppShell(
                child: child,
              ),
            );
          },
          routes: [
            // RUTA DE INICIO
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(), 
            ),
            // RUTA DE NOSOTROS
            GoRoute(
              path: '/about',
              builder: (context, state) => const AboutPage(), 
            ),
            // RUTA DE SERVICIOS
            GoRoute(
              path: '/services',
              builder: (context, state) => const ServicesPage(),
              routes: [
                GoRoute(
                  path: ':serviceId',
                  builder: (context, state) => const ServicesPage(),
                ),
              ],
            ),
            
            // RUTA: PUBLICACIONES
            GoRoute(
              path: '/publishings',
              builder: (context, state) => const PublishingsPage(), 
              routes: [
                GoRoute(
                  path: ':articleId', 
                  builder: (context, state) => const PublishingsPage(),
                ),
              ],
            ),
            
            // RUTA: CONTACTO
            GoRoute(
              path: '/contact',
              builder: (context, state) => const ContactPage(),
            ),
          ],
        ),
      ],
    );
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    
    // Sincroniza el modo oscuro del sistema solo si es necesario
    final newMode = platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    if (_themeMode.value != newMode) {
      _themeMode.value = newMode;
    }
  }
  
  @override
  void dispose() {
    _themeMode.dispose();
    _language.dispose();
    _router.dispose(); 
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder solo escucha _themeMode para reconstruir MaterialApp
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, themeMode, _) { 
        return MaterialApp.router( 
          title: 'iGenCore',
          themeMode: themeMode,
          // 🚨 APLICACIÓN DE LA SOLUCIÓN DE SCROLL
          scrollBehavior: const AppScrollBehavior(), 
          
          theme: getLightTheme(),
          darkTheme: getDarkTheme(),
          routerConfig: _router, 
        );
      },
    );
  }
}

// ⚠️ NOTA: Falta la definición del widget AppState, 
// asumo que está definido en otro archivo o más abajo en este archivo.
// Su uso con ValueNotifier es una excelente práctica.