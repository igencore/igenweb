// Archivo: lib/main.dart (VERSIÓN FINAL CON RUTAS Y APPSTATE INYECTADO)

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart'; 
import 'package:flutter_web_plugins/flutter_web_plugins.dart'; 

// ==========================================================
// 1. Importaciones de Páginas y Shell
// ==========================================================
import 'pages/home_page.dart'; 
import 'pages/about_page.dart'; 
import 'pages/services_page.dart'; 
import 'pages/contact_page.dart'; // 🚨 IMPORTACIÓN AÑADIDA
import 'pages/research_page.dart'; // 🚨 IMPORTACIÓN AÑADIDA
import 'app_shell.dart'; 

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
              // AppShell ya no necesita recibir los notifiers como argumentos
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
              // Aseguramos la ruta para los detalles de servicios
              routes: [
                GoRoute(
                  path: ':serviceId',
                  builder: (context, state) => const ServicesPage(), // Usamos ServicesPage como fallback/base
                ),
              ],
            ),
            
            // 🚨 RUTA AÑADIDA: INVESTIGACIÓN
            GoRoute(
              path: '/research',
              builder: (context, state) => const ResearchPage(), 
              routes: [
                GoRoute(
                  path: ':articleId', // Para URLs como /research/mineria-sostenible
                  builder: (context, state) => const ResearchPage(), // Usamos ResearchPage como fallback/base
                ),
              ],
            ),
            
            // 🚨 RUTA AÑADIDA: CONTACTO
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
    _router.dispose(); // Es buena práctica liberar el router
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const Color seedColor = Colors.deepOrange; 
    
    // ValueListenableBuilder solo escucha _themeMode para reconstruir MaterialApp
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, themeMode, _) { 
        return MaterialApp.router( 
          title: 'iGenCore',
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData( 
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed( 
              seedColor: seedColor,
              brightness: Brightness.dark,  
            ),
          ),
          routerConfig: _router, 
        );
      },
    );
  }
}