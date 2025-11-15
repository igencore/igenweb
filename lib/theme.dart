// Archivo: lib/theme.dart
// Paleta: Amarillo (Acento), Celeste (Primario), Azul Profundo (Secundario/Fondo Oscuro)

import 'package:flutter/material.dart';
// 🚨 Importación necesaria para usar Google Fonts sin descargar archivos
import 'package:google_fonts/google_fonts.dart'; 

// ====================================================================
// 1. CONSTANTES DE COLOR BASE
// ====================================================================

// Colores de la Marca
const Color primaryCeleste = Color(0xFF1671D8);       // Celeste (Azul vibrante) - Principal
const Color secondaryAzulProfundo = Color(0xFF0F2C65); // Azul Profundo (Marca, fondo oscuro) - Secundario
const Color accentAmarillo = Color(0xFFF6BD20);        // Amarillo (Acento, llamado tertiary) - Acento

// CONSTANTES DE BOTÓN (Amarillo Brillante / Texto Negro)
const Color buttonAmarilloBrillante = Color(0xFFFFEB3B); 
const Color buttonTextoNegro = Colors.black;

// Colores de Fondo (Usados para scaffoldBackgroundColor)
const Color lightBackground = Color(0xFFFAFAFA);       // Gris claro para Scaffold (Modo Claro)
const Color darkBackground = Color(0xFF081C45);        // Azul Muy Oscuro para Scaffold (Modo Oscuro)


// ====================================================================
// 2. ESQUEMA DE COLOR PARA MODO CLARO (_lightColorScheme)
// ====================================================================

final ColorScheme _lightColorScheme = const ColorScheme.light().copyWith(
  primary: primaryCeleste,                              
  onPrimary: Colors.white,                              
  secondary: secondaryAzulProfundo,                     
  onSecondary: Colors.white,                            
  surface: Colors.white,                                
  onSurface: secondaryAzulProfundo,                     
  primaryContainer: const Color(0xFFFFF8E1),            
  onPrimaryContainer: secondaryAzulProfundo,            
  tertiary: accentAmarillo,
  onTertiary: secondaryAzulProfundo,                    
  error: const Color(0xFFB00020),
  
  // 🚨 AJUSTE CLAVE: Nuevo color para las tarjetas secundarias (gris claro)
  surfaceContainerLow: const Color(0xFFF0F0F0),
);


// ====================================================================
// 3. ESQUEMA DE COLOR PARA MODO OSCURO (_darkColorScheme)
// ====================================================================

final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
  primary: buttonAmarilloBrillante,                     // Amarillo brillante
  onPrimary: buttonTextoNegro,                          // Texto negro
  secondary: primaryCeleste,                            
  onSecondary: Colors.white,                            
  surface: secondaryAzulProfundo,                       
  onSurface: Colors.white,                              
  primaryContainer: const Color(0xFF0B5AA8),            
  onPrimaryContainer: Colors.white,                     
  tertiary: accentAmarillo,
  onTertiary: secondaryAzulProfundo,
  error: const Color(0xFFCF6679),
);


// ====================================================================
// 4. DEFINICIÓN FINAL DE TEMAS
// ====================================================================

/// Retorna el [ThemeData] completo para el modo claro.
ThemeData getLightTheme() {
  // Define Lato como la fuente base para todo el tema claro
  final baseTextTheme = GoogleFonts.latoTextTheme(ThemeData.light().textTheme);
  
  return ThemeData(
    useMaterial3: true,
    // 🚨 Aplicación de la tipografía Lato
    textTheme: baseTextTheme,
    // Se elimina fontFamily: 'Lato'
    
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: lightBackground, 
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // Colores forzados para Amarillo Brillante / Negro
        backgroundColor: buttonAmarilloBrillante, 
        foregroundColor: buttonTextoNegro, 
        elevation: 0, 
        shadowColor: Colors.transparent, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        // 🚨 Estilo de texto Lato para el botón
        textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

/// Retorna el [ThemeData] completo para el modo oscuro.
ThemeData getDarkTheme() {
  // Define Lato como la fuente base para todo el tema oscuro
  final baseTextTheme = GoogleFonts.latoTextTheme(ThemeData.dark().textTheme);
  
  return ThemeData(
    useMaterial3: true,
    // 🚨 Aplicación de la tipografía Lato
    textTheme: baseTextTheme,
    // Se elimina fontFamily: 'Lato'
    
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: darkBackground,
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _darkColorScheme.onPrimary, 
        backgroundColor: _darkColorScheme.primary, 
        elevation: 0, 
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        // 🚨 Estilo de texto Lato para el botón
        textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}