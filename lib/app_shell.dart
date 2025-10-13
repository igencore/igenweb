// Archivo: lib/app_shell.dart (OPTIMIZADO Y CORREGIDO EL CONSTRUCTOR)

import 'package:flutter/material.dart';

// Importa tu Header y Drawer
import 'components/header.dart'; 
import 'drawer.dart'; 

// ==========================================================
// 1. INHERITED WIDGET PARA GESTIÓN DE ESTADO (AppState)
// ==========================================================
class AppState extends InheritedNotifier<Listenable> {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  final ValueNotifier<String> languageNotifier;

  const AppState({
    super.key,
    required this.themeModeNotifier,
    required this.languageNotifier,
    required super.child,
  }) : super(notifier: themeModeNotifier); 
  
  static AppState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }
  
  static AppState of(BuildContext context) {
    final AppState? result = maybeOf(context);
    assert(result != null, 'No se encontró AppState en el contexto');
    return result!;
  }

  static ValueNotifier<String> languageOf(BuildContext context) {
    // Es más seguro usar maybeOf y el null-check para evitar el assertion error fuera del build
    return maybeOf(context)!.languageNotifier;
  }
}

// ==========================================================
// 2. APP SHELL (El Layout principal)
// ==========================================================
class AppShell extends StatelessWidget {
  final Widget child; 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 🚨 CORRECCIÓN 1: Constructor simplificado y optimizado
  AppShell({
    super.key,
    required Widget child,
  }) : 
    // Aseguramos que 'child' siempre tenga una clave estable para AnimatedSwitcher
    child = (child.key == null || child.key is! ValueKey)
      ? KeyedSubtree(key: ValueKey(child.runtimeType.toString()), child: child)
      : child; 


  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final themeModeNotifier = appState.themeModeNotifier;
    
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    // Obtenemos la clave segura (garantizada por el constructor)
    final Key safeKey = child.key!; 

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      // 🚨 CORRECCIÓN 2: Pasamos el 'child' al ValueListenableBuilder para evitar re-creación
      child: child, 
      builder: (context, _, child) { 
        
        final isDarkMode = themeModeNotifier.value == ThemeMode.dark;
        // NOTA: Asume que las rutas de assets son correctas
        final logoPath = isDarkMode
            ? 'assets/images/logoigenwhite.png'
            : 'assets/images/logoigenblack.png';
        final logoWidget = Image.asset(logoPath, height: 24);
        
        return Scaffold(
          key: _scaffoldKey,
          // 1. HEADER 
          appBar: Header(
            scaffoldKey: _scaffoldKey, 
          ),
          
          // 2. DRAWER 
          endDrawer: isDesktop
              ? null
              : CustomDrawer( 
                  logoWidget: logoWidget,
                ),
                
          // 3. BODY: Implementación del AnimatedSwitcher
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350), 
            
            // Usamos la clave segura para identificar el cambio de página
            key: ValueKey(safeKey), 
            // 🚨 OPTIMIZACIÓN: Usamos el 'child' del builder (que es el 'child' del Shell)
            child: child!, 
            
            // Transición de Fade-in/Fade-out
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                // 🚨 OPTIMIZACIÓN: No es necesario reasignar la clave aquí.
                // El child ya tiene la clave inyectada por el constructor.
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}