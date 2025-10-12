// Archivo: lib/services_intro.dart (Optimizado para Rendimiento Móvil y Scroll)

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; 
import 'dart:math';
import 'dart:ui'; // Necesario para PointMode

import 'translations.dart'; 

class ServicesIntroSection extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;
  final VoidCallback onServicesTap; 

  const ServicesIntroSection({
    super.key, 
    required this.languageNotifier,
    required this.onServicesTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, _) {
  
        final serviceText = appTranslations[language]!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800), 
              child: Column(
                children: [
                  Text(
                    serviceText['services_intro_title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface, 
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    serviceText['services_intro_subtitle'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(179),
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // ANIMACIÓN DE NUBE DE PUNTOS
                  // CLAVE DE OPTIMIZACIÓN: RepaintBoundary aísla la pintura compleja del scroll.
                  RepaintBoundary( 
                    child: ReliefPointCloudAnimation(
                      themeModeNotifier: ValueNotifier(Theme.of(context).brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light),
                    ),
                  ),
                  
                  const SizedBox(height: 40), 

                  // BOTÓN DE SERVICIOS
                  FilledButton.tonal(
                    onPressed: onServicesTap,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      serviceText['services_button_text'] ?? 'Servicios',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget que maneja la animación de la nube de puntos
class ReliefPointCloudAnimation extends HookWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier; 

  const ReliefPointCloudAnimation({super.key, required this.themeModeNotifier});

  @override
  Widget build(BuildContext context) {
    final rotationController = useAnimationController(
      duration: const Duration(seconds: 40), 
    )..repeat(reverse: false); 

    final baseColor = Theme.of(context).colorScheme.onSurface;
    final primaryColor = Theme.of(context).colorScheme.primary; 

    // Detectar si estamos en móvil para reducir la carga de cómputo.
    final screenWidth = MediaQuery.of(context).size.width;
    // Consideramos móvil o tablet pequeña si el ancho es menor a 800
    final bool isMobile = screenWidth < 800; 
    
    // Conteo de puntos reducido para móviles: 25x25 (625 puntos) vs 40x40 (1600 puntos)
    final int numPoints = isMobile ? 25 : 40; // <-- CLAVE: REDUCCIÓN CONDICIONAL

    // Aumento de tamaño para escritorio (si el ancho es > 800px)
    final double baseWidth = 600;
    final double baseHeight = 300;
    
    final double width = !isMobile ? baseWidth * 1.3 : baseWidth; 
    final double height = !isMobile ? baseHeight * 1.3 : baseHeight;
    
    return AnimatedBuilder(
      animation: rotationController, 
      builder: (context, child) {
        return SizedBox(
          // === AJUSTE DE TAMAÑO APLICADO AQUÍ ===
          width: width, 
          height: height,
          child: CustomPaint(
            painter: ReliefPainter(
              animationValue: rotationController.value, 
              baseColor: baseColor,
              primaryColor: primaryColor, 
              numPointsX: numPoints, // <-- PASAR EL VALOR REDUCIDO
              numPointsY: numPoints, // <-- PASAR EL VALOR REDUCIDO
            ),
          ),
        );
      },
    );
  }
}

// === CUSTOM PAINTER CON BORDE ORGÁNICO E IRREGULAR ===
class ReliefPainter extends CustomPainter {
  final double animationValue; 
  final Color baseColor;
  final Color primaryColor; 

  // Aceptar el conteo de puntos desde el widget
  final int numPointsX; 
  final int numPointsY; 

  final double spacing = 10.0; 
  final double terraceHeight = 8.0; 
  final double maxReliefDepth = 120.0; 
  
  final double isometricAngleX = 0.8; 
  final double isometricAngleY = 0.5; 

  final Offset craterCenter1 = const Offset(-40.0, 0.0);
  final Offset craterCenter2 = const Offset(40.0, 0.0); 

  ReliefPainter({
    super.repaint, 
    required this.animationValue, 
    required this.baseColor, 
    required this.primaryColor,
    this.numPointsX = 40, 
    this.numPointsY = 40, 
  });

  double _noise(double x, double y, double t) {
    double n = 0;
    n += sin(x * 0.1 + t * 0.5) * cos(y * 0.1 + t * 0.3) * 0.5;
    n += sin(x * 0.2 + t * 0.7) * cos(y * 0.2 + t * 0.4) * 0.25;
    n += sin(x * 0.05 + t * 0.2) * cos(y * 0.05 + t * 0.1) * 0.15;
    return n.clamp(-1.0, 1.0); 
  }

  double getReliefHeight(double x, double y) {
    final maxGridDist = numPointsX * spacing / 2.0;
    final distance = sqrt(pow(x, 2) + pow(y, 2)); 
    final normalizedRadius = distance / maxGridDist;

    // --- 1. Ruido General del Terreno (MÁS INFLUENCIA EN BORDES) ---
    final powRadius4 = pow(normalizedRadius, 4.0).clamp(0.0, 10.0); 
    final noiseInfluenceFactor = 1.0 + powRadius4 * 1.5; 
    final terrainNoise = _noise(x * 0.05, y * 0.05, animationValue * 5) * 20.0 * noiseInfluenceFactor; 
    if (!terrainNoise.isFinite) return 0.0; 

    // --- 2. MODELADO DEL DOBLE YACIMIENTO (Inversa Cuadrática) ---
    final dist1 = sqrt(pow(x - craterCenter1.dx, 2) + pow(y - craterCenter1.dy, 2));
    final normalizedDist1 = dist1 / maxGridDist * 1.5; 
    final pitInfluence1 = 1.0 / (1.0 + pow(normalizedDist1, 4.0).clamp(0.0, 100.0) * 10.0);

    final dist2 = sqrt(pow(x - craterCenter2.dx, 2) + pow(y - craterCenter2.dy, 2));
    final normalizedDist2 = dist2 / maxGridDist * 1.5;
    final pitInfluence2 = 1.0 / (1.0 + pow(normalizedDist2, 4.0).clamp(0.0, 100.0) * 10.0);

    final pitInfluence = max(pitInfluence1, pitInfluence2);

    final pitDepth = pitInfluence * maxReliefDepth * 0.7; 
    final pitFloorNoise = _noise(x * 0.1, y * 0.1, animationValue * 3) * 10.0; 
    
    if (!pitDepth.isFinite) return 0.0; 
    
    // --- 3. MODELADO DE BORDES MONTAÑOSOS ---
    final mountainInfluence = (pow(normalizedRadius, 2.0)).clamp(0.0, 1.0); 
    final mountainHeight = mountainInfluence * maxReliefDepth * 0.4; 

    final mountainPeakNoise = _noise(x * 0.08, y * 0.08, animationValue * 4) * 15.0;

    // --- 4. COMBINACIÓN Y TERRAZAS ---
    final rawZ = terrainNoise - pitDepth + pitFloorNoise + mountainHeight + mountainPeakNoise;

    if (!rawZ.isFinite) return 0.0; 

    final terraceIndex = (rawZ / terraceHeight).floor();
    return terraceIndex * terraceHeight;
  }
  
  Offset project(double x, double y, double z, Size size) {
    final angle = animationValue * 2 * pi; 

    final rotatedX = x * cos(angle) - y * sin(angle);
    final rotatedY = x * sin(angle) + y * cos(angle);
    
    final projectedX = rotatedX * cos(isometricAngleY) - rotatedY * sin(isometricAngleY);
    final projectedY = rotatedX * sin(isometricAngleY) * cos(isometricAngleX) + rotatedY * cos(isometricAngleY) * cos(isometricAngleX) - z * sin(isometricAngleX);

    final scale = size.width / (numPointsX * spacing * 1.5);
    final finalX = projectedX * scale + size.width / 2;
    final finalY = projectedY * scale + size.height * 0.5; 
    
    if (!finalX.isFinite || !finalY.isFinite) return Offset.zero; 

    return Offset(finalX, finalY);
  }

  @override
  void paint(Canvas canvas, Size size) {
    
    final linePaint = Paint()
      ..color = primaryColor.withAlpha(26) 
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Pintura de puntos configurada para drawPoints
    final pointPaint = Paint() 
      ..strokeCap = StrokeCap.round 
      ..strokeWidth = 1.8 
      ..color = baseColor.withAlpha(128)
      ..style = PaintingStyle.stroke; 
      
    final List<Offset> pointsToDraw = []; 
    final List<List<Offset>> projectedPoints = List.generate(numPointsX, (_) => List.filled(numPointsY, Offset.zero));

    // 1. CALCULAR PROYECCIONES y LLENAR LISTA DE PUNTOS
    for (int i = 0; i < numPointsX; i++) {
      for (int j = 0; j < numPointsY; j++) {
        final x3d = (i - numPointsX / 2) * spacing;
        final y3d = (j - numPointsY / 2) * spacing;
        final z3d = getReliefHeight(x3d, y3d);
        
        final projected = project(x3d, y3d, z3d, size);
        projectedPoints[i][j] = projected;
        pointsToDraw.add(projected); 
      }
    }
    
    // 2. DIBUJAR LÍNEAS (MESH) 
    for (int j = 0; j < numPointsY; j++) { 
      for (int i = 0; i < numPointsX; i++) {
        final current = projectedPoints[i][j];

        if (current == Offset.zero && i > 0 && j > 0) continue; 
        
        // Líneas en X
        if (i < numPointsX - 1) {
          final nextX = projectedPoints[i + 1][j];
          canvas.drawLine(current, nextX, linePaint);
        }
        // Líneas en Y
        if (j < numPointsY - 1) {
          final nextY = projectedPoints[i][j + 1];
          canvas.drawLine(current, nextY, linePaint);
        }
      }
    }

    // 3. DIBUJAR PUNTOS - ¡OPTIMIZADO CON drawPoints!
    if (pointsToDraw.isNotEmpty) {
      canvas.drawPoints(PointMode.points, pointsToDraw, pointPaint); 
    }
  }

  @override
  bool shouldRepaint(ReliefPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.baseColor != baseColor ||
           oldDelegate.primaryColor != primaryColor ||
           oldDelegate.numPointsX != numPointsX || 
           oldDelegate.numPointsY != numPointsY; 
  }
}