// Archivo: lib/components/header.dart (¡CON LÓGICA DE RESPONSIVIDAD Y LOGO Y APPSTATE!)

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; deactivated
import '../app_shell.dart'; // 🚨 Importamos AppState

// Importa los componentes que usa la AppBar
import 'themetoggle.dart';
import 'langtoggle.dart';
import 'mainmenu.dart'; 

class Header extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey; 

  const Header({
    super.key,
    this.scaffoldKey, 
  });

  @override
  Widget build(BuildContext context) {
    // 🚨 Accedemos a los Notifiers vía AppState
    final appState = AppState.of(context);
    final themeModeNotifier = appState.themeModeNotifier;
    final languageNotifier = appState.languageNotifier;

    // === LÓGICA DE RESPONSIVIDAD ===
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    
    // Envuelve el widget en un ValueListenableBuilder para que el logo se actualice con el tema.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        
        final isDarkMode = themeMode == ThemeMode.dark;
        final logoPath = isDarkMode
            ? 'assets/images/logoigenwhite.png'
            : 'assets/images/logoigenblack.png';
        
      final logoWidget = Padding( 
          // Logo con padding de 2.0 arriba y abajo
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 4.0),
          child: Image.asset(
            logoPath,
            height: 35, // Altura del logo
          ),
        );

        return AppBar(
          centerTitle: false, 
          title: isDesktop
              // 🚀 SOLUCIÓN DE ALINEACIÓN FINAL: Usamos IntrinsicHeight.
              // Fuerza a la Row a tomar la altura mínima necesaria (58.0).
              ? IntrinsicHeight( 
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center, // 👈 CLAVE: Centrar verticalmente en la altura mínima
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row( // Lado izquierdo (Toggle Tema + Logo)
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: [
                            // 🚨 Se pasan los notifiers A los widgets internos
                            ThemeToggle(themeModeNotifier: themeModeNotifier), 
                            const SizedBox(width: 8),
                            logoWidget,
                          ],
                        ),
                        // Lado derecho (Menú + Toggle Idioma)
                        MainMenu(languageNotifier: languageNotifier), 
                        LanguageToggle(languageNotifier: languageNotifier), 
                      ],
                  ),
                )
              : Row( // Versión móvil: Solo Toggle Tema y Logo
                  crossAxisAlignment: CrossAxisAlignment.center, // Centrar verticalmente para móvil
                  children: [
                    ThemeToggle(themeModeNotifier: themeModeNotifier),
                    const SizedBox(width: 8),
                    logoWidget,
                  ],
                ),
          actions: isDesktop
              ? null // En escritorio, el MainMenu está en el 'title'
              : [ // En móvil: Toggle Idioma y botón de menú
                  LanguageToggle(languageNotifier: languageNotifier),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        // Usa la clave Scaffold que se le pasa
                        scaffoldKey?.currentState?.openEndDrawer(); 
                      },
                    ),
                  ),
                ],
        );
      },
    );
  }

  @override
  // 🚀 Altura preferida: Ajustamos a la altura mínima real (54 + 2 + 2 = 58.0)
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 
}