// Archivo: lib/components/header.dart (¡CON LÓGICA DE RESPONSIVIDAD Y LOGO Y APPSTATE!)

import 'package:flutter/material.dart';
import '../app_shell.dart'; // 🚨 NUEVO: Importamos AppState

// Importa los componentes que usa la AppBar
import 'themetoggle.dart';
import 'langtoggle.dart';
import 'mainmenu.dart'; 

class Header extends StatelessWidget implements PreferredSizeWidget {
  // 🚨 CORRECCIÓN 1: Eliminados los ValueNotifier del constructor
  final GlobalKey<ScaffoldState>? scaffoldKey; 

  const Header({
    super.key,
    // 🚨 Eliminados: themeModeNotifier, languageNotifier
    this.scaffoldKey, 
  });

  @override
  Widget build(BuildContext context) {
    // 🚨 CORRECCIÓN 2: Accedemos a los Notifiers vía AppState
    final appState = AppState.of(context);
    final themeModeNotifier = appState.themeModeNotifier;
    final languageNotifier = appState.languageNotifier;

    // === LÓGICA DE RESPONSIVIDAD ===
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    
    // 🚨 CORRECCIÓN 3: Envuelve el widget en un ValueListenableBuilder para 
    // que el logo (y el tema) se actualicen cuando cambia themeModeNotifier.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        
        final isDarkMode = themeMode == ThemeMode.dark;
        final logoPath = isDarkMode
            ? 'assets/images/logoigenwhite.png'
            : 'assets/images/logoigenblack.png';
        
        final logoWidget = Image.asset(
          logoPath,
          height: 24,
        );

        return AppBar(
          title: isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row( // Lado izquierdo (Toggle Tema + Logo)
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
                )
              : Row( // Versión móvil: Solo Toggle Tema y Logo
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}