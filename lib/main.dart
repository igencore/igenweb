// Archivo: lib/main.dart (Versión Final, Limpia y Estable)

import 'package:flutter/material.dart';
import 'themetoggle.dart';
import 'langtoggle.dart';
import 'mainmenu.dart';
import 'drawer.dart';
import 'hero.dart';
import 'logo_carousel.dart'; 
import 'services_intro.dart'; 
import 'research_section.dart'; 
import 'contact_section.dart'; 
import 'footer_section.dart'; // <--- IMPORTACIÓN RESTAURADA


void main() {
  runApp(const IgenCoreApp());
}

class IgenCoreApp extends StatefulWidget {
  const IgenCoreApp({super.key});

  @override
  State<IgenCoreApp> createState() => _IgenCoreAppState();
}

class _IgenCoreAppState extends State<IgenCoreApp> {
  late final ValueNotifier<ThemeMode> _themeMode;
  late final ValueNotifier<String> _language;

  @override
  void initState() {
    super.initState();
    _themeMode = ValueNotifier(ThemeMode.light);
    _language = ValueNotifier('ES');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    _themeMode.value = platformBrightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
  
  @override
  void dispose() {
    _themeMode.dispose();
    _language.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color seedColor = Colors.deepOrange; 
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'iGenCore',
          // ==========================================================
          // 1. CONFIGURACIÓN DEL TEMA CLARO (theme)
          // ==========================================================
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ),
          ),
          // ==========================================================
          // 2. CONFIGURACIÓN DEL TEMA OSCURO (darkTheme)
          // ==========================================================
          darkTheme: ThemeData( 
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed( // <-- Creado a partir de la semilla
              seedColor: seedColor,
              brightness: Brightness.dark,  
            ),
          ),

          themeMode: themeMode,
          home: HomePage(
            themeModeNotifier: _themeMode,
            languageNotifier: _language,
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  final ValueNotifier<String> languageNotifier;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({
    super.key,
    required this.themeModeNotifier,
    required this.languageNotifier,
  });

  // Función de navegación para el botón de Servicios (Usando debugPrint)
  void _handleServicesTap(BuildContext context) {
    debugPrint("Botón 'Servicios' presionado. ¡Implementa tu navegación!"); 
  }
  
  // Función de navegación para el botón de Formulario de Contacto (Usando debugPrint)
  void _handleFormTap(BuildContext context) {
    debugPrint("Botón 'Formulario' de Contacto presionado.");
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    final isDarkMode = themeModeNotifier.value == ThemeMode.dark;
    final logoPath = isDarkMode
        ? 'assets/images/logoigenwhite.png'
        : 'assets/images/logoigenblack.png';
    
    final logoWidget = Image.asset(
      logoPath,
      height: 24,
    );
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ThemeToggle(themeModeNotifier: themeModeNotifier),
                      const SizedBox(width: 8),
                      logoWidget,
                    ],
                  ),
                  MainMenu(
                    languageNotifier: languageNotifier,
                  ),
                  LanguageToggle(languageNotifier: languageNotifier),
                ],
              )
            : Row(
                children: [
                  ThemeToggle(themeModeNotifier: themeModeNotifier),
                  const SizedBox(width: 8),
                  logoWidget,
                ],
              ),
        actions: isDesktop
            ? null
            : [
                LanguageToggle(languageNotifier: languageNotifier),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ),
              ],
      ),
      endDrawer: isDesktop
          ? null
          : CustomDrawer(
              languageNotifier: languageNotifier,
              logoWidget: logoWidget,
              themeModeNotifier: themeModeNotifier,
            ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // 1. Sección Hero
              HeroSection(languageNotifier: languageNotifier),
              
              // 2. Espacio de separación
              const SizedBox(height: 36), 

              // 3. Carousel de Logos
              const LogoCarousel(),

              // 4. Espacio antes de la próxima sección
              const SizedBox(height: 36),
              
              // 5. INTRODUCCIÓN DE SERVICIOS
              ServicesIntroSection(
                languageNotifier: languageNotifier,
                onServicesTap: () => _handleServicesTap(context), 
              ),

              // 6. NUEVA SECCIÓN: INVESTIGACIÓN
              ResearchSection(languageNotifier: languageNotifier), 
              
              // 7. Espacio
              const SizedBox(height: 48),

              // 8. NUEVA SECCIÓN: CONTÁCTANOS
              ContactSection(
                languageNotifier: languageNotifier,
                onFormTap: () => _handleFormTap(context), 
              ),
              
              // 9. PIE DE PÁGINA (FOOTER)
              FooterSection(languageNotifier: languageNotifier), // <--- WIDGET FOOTER RESTAURADO
            ],
          ),
        ),
      ),
    );
  }
}