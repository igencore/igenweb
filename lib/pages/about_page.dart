// Archivo: lib/pages/about_page.dart (CON IMAGEN HERO MOVIDA Y ESCALADA EN MOBILE)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import '../app_shell.dart'; 

import '../components/contact_section.dart'; 
import '../components/footer_section.dart'; 

// ====================================================================
// DEFINICIÓN DE CLAVES GLOBALES PARA LAS ANCLAS (SECCIONES)
// ====================================================================

final GlobalKey _propositoKey = GlobalKey();
final GlobalKey _enfoqueKey = GlobalKey();
final GlobalKey _trayectoriaKey = GlobalKey();

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _lastCheckedHash = ''; 
  
  // --- Helpers de Contenido ---

  Map<String, String> getSectionTitles(String lang) {
    return lang == 'ES' ? {
      'proposito': 'Propósito y Visión',
      'enfoque': 'Enfoque Integral',
      'trayectoria': 'Trayectoria y Logros',
      'contact_title': 'Contáctanos para una Solución'
    } : {
      'proposito': 'Purpose and Vision',
      'enfoque': 'Integral Approach',
      'trayectoria': 'Trajectory and Achievements',
      'contact_title': 'Contact Us for a Solution'
    };
  }

  Map<String, String> getSectionContent(String lang) {
    return lang == 'ES' ? {
      'p1': 'Somos una empresa chilena constituida legalmente en 2021, con el deseo de entregar **soluciones integrales e innovadoras** que pudiesen incorporar la ingeniería, metalurgia, geología y la pasión por la investigación. Nuestro principal propósito es satisfacer las necesidades operacionales de nuestros clientes con el fin de optimizar y enriquecer la ejecución de los procesos involucrados en la minería.',
      'p2': 'Como resultado de nuestra fundación, hemos logrado una empresa con un marcado **carácter tecnológico e industrial**, destacando en la optimización de procesamiento de minerales, exploración geológica, mejoramiento en el transporte de fluidos, metalmecánica y automatización de procesos industriales. Estas áreas son requeridas en un amplio espectro de mercados, como la minería.',
      'p3': 'Nuestro enfoque integral se lleva a cabo gracias a la experiencia de nuestros **profesionales multidisciplinarios** de vasta trayectoria industrial. Este equipo es el pilar que da respuesta a las necesidades operacionales de la minería, impulsando la innovación y eficiencia en cada proyecto de nuestros clientes.',
    } : {
      'p1': 'We are a Chilean company, legally stablished in 2021, with the aim of providing **integral and innovative solutions** that encompass engineering, metallurgy, geology, and our passion for research. Our main objective is to meet the operational needs of our clients to optimize and enhance the execution of the processes involved in the mining industry.',
      'p2': 'As a result of our establishment, we have created a company with a distinct **technological and industrial focus**, excelling in the optimization of mineral processing, geological exploration, fluid transportation improvements, metal-mechanic industry, and industrial process automation. These areas are in constant demand across a wide range of markets, such as the mining industry.',
      'p3': 'Our integral approach is carried out thanks to the experience of our **multidisciplinary professionals** with extensive industrial experience. This team is the pillar that responds to the operational needs of the mining sector, driving innovation and efficiency in every client project.',
    };
  }
  
  // --- Función de Scroll al Ancla ---
  void _scrollToSection(BuildContext context, String hash) {
    GlobalKey? key;
    if (hash == '#proposito') key = _propositoKey;
    if (hash == '#enfoque') key = _enfoqueKey;
    if (hash == '#trayectoria') key = _trayectoriaKey;

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.1, 
      );
    }
  }

  // Implementar didChangeDependencies para manejar el scroll de forma segura
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final currentHash = GoRouterState.of(context).uri.fragment;
    final fullHash = currentHash.isNotEmpty ? '#$currentHash' : '';

    if (fullHash.isNotEmpty && fullHash != _lastCheckedHash) {
       _lastCheckedHash = fullHash;
      
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (mounted) {
           _scrollToSection(context, fullHash);
         }
       });
    }
  }


  @override
  Widget build(BuildContext context) {
    final languageNotifier = AppState.of(context).languageNotifier;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor; 
    
    // --- VARIABLES DE RESPONSIVIDAD Y TEMA ---
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final themeModeNotifier = AppState.of(context).themeModeNotifier;
    final colorScheme = Theme.of(context).colorScheme;
    
    // CÁLCULO DEL ANCHO DE LA IMAGEN
    // Escritorio: 33% (original)
    // Móvil: 50% * 1.30 (30% más grande) = 65% del ancho de pantalla
    final mobileImageScaleFactor = 1.30; // 30% extra
    final imageWidth = screenWidth * (isDesktop ? 0.33 : (0.50 * mobileImageScaleFactor));
    
    return SingleChildScrollView(
      child: Container(
        color: backgroundColor, 
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        
        child: ValueListenableBuilder<String>(
          valueListenable: languageNotifier,
          builder: (context, language, child) {
            final titles = getSectionTitles(language);
            final content = getSectionContent(language);
            
            return Column( // Columna principal de AboutPage
              children: [
                // 1. TÍTULOS PRINCIPALES Y SUBTÍTULO
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       // TÍTULO PRINCIPAL
                      Text(
                        language == 'ES' ? 'Quiénes Somos' : 'Who We Are',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // SUBTÍTULO
                      Text(
                        language == 'ES' ? 'Ingeniería, Innovación y Enfoque Industrial.' : 'Engineering, Innovation, and Industrial Focus.',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // 🚨 2. IMAGEN HERO MOVIDA Y ESCALADA (DEBAJO DE LOS TÍTULOS)
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeModeNotifier,
                  builder: (context, themeMode, _) {
                    final isDarkMode = themeMode == ThemeMode.dark;
                    
                    // Rutas con extensión .jpg
                    final logoPath = isDarkMode
                        ? 'assets/images/aboutusblack.jpg'
                        : 'assets/images/aboutuswhite.jpg';
                        
                    return Column(
                      children: [
                        Image.asset(
                          logoPath, 
                          width: imageWidth, // Usa el ancho calculado dinámicamente
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 40), // Espacio antes de la primera sección
                      ],
                    );
                  },
                ),
                
                // 3. CONTENIDO DETALLADO CON ANCLAS (Propósito, Enfoque, Trayectoria)
                Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- SECCIÓN 1: Propósito y Visión (Ancla: #proposito) ---
                      _Section(
                        key: _propositoKey,
                        title: titles['proposito']!,
                        content: content['p1']!,
                        colorScheme: Theme.of(context).colorScheme,
                        iconData: Icons.lightbulb_outline,
                        imageFirst: true, 
                      ),
                      
                      // --- SECCIÓN 2: Enfoque Integral (Ancla: #enfoque) ---
                      _Section(
                        key: _enfoqueKey,
                        title: titles['enfoque']!,
                        content: content['p2']!,
                        colorScheme: Theme.of(context).colorScheme,
                        iconData: Icons.widgets_outlined,
                        imageFirst: false,
                      ),

                      // --- SECCIÓN 3: Trayectoria y Logros (Ancla: #trayectoria) ---
                      _Section(
                        key: _trayectoriaKey,
                        title: titles['trayectoria']!,
                        content: content['p3']!,
                        colorScheme: Theme.of(context).colorScheme,
                        iconData: Icons.trending_up,
                        imageFirst: true,
                      ),
                    ],
                  ),
                ),

                // 4. SECCIÓN DE CONTACTO (Componente ContactSection)
                Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh, 
                  child: ContactSection(), 
                ),
                
                // 5. FOOTER
                const FooterSection(),
              ],
            );
          },
        ),
      ),
    );
  }
}


// ====================================================================
// 🚀 WIDGET: _AboutHeroSection ELIMINADO/INTEGRADO
// ====================================================================

// El widget _AboutHeroSection original fue eliminado e integrado
// en el widget _AboutPageState para facilitar el cambio de layout.
// El código de la imagen ahora reside directamente en el build de _AboutPageState.


// ====================================================================
// WIDGET PRIVADO PARA ESTRUCTURAR CADA SECCIÓN (Sin cambios)
// ====================================================================

class _Section extends StatelessWidget {
  const _Section({
    super.key,
    required this.title,
    required this.content,
    required this.colorScheme,
    required this.iconData, 
    required this.imageFirst,
  });

  final String title;
  final String content;
  final ColorScheme colorScheme;
  final IconData iconData; 
  final bool imageFirst;

  @override
  Widget build(BuildContext context) {
    
    final iconTitleWidget = Container(
      width: 48, 
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer, 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(
          iconData, 
          size: 28, 
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
    
    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconTitleWidget,
            const SizedBox(width: 16),
            Expanded( 
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        SelectableText(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0), 
      child: textWidget,
    );
  }
}