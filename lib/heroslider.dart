// Archivo: lib/heroslider.dart

import 'package:flutter/material.dart';
import 'dart:async'; // Necesario para el Timer

class HeroSlider extends StatefulWidget {
  // Ahora la sección HeroSection que lo usa debe determinar su altura
  const HeroSlider({super.key});

  @override
  State<HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> with SingleTickerProviderStateMixin {
  final List<String> images = [
    'assets/images/slide1.jpg',
    'assets/images/slide2.jpg',
    'assets/images/slide3.jpg',
  ];

  late AnimationController _controller;
  int _currentIndex = 0;
  int _previousIndex = 0; 
  Timer? _slideshowTimer; // 🚨 Uso de Timer para un control más limpio

  // Duraciones
  static const Duration _fadeDuration = Duration(milliseconds: 1500);
  static const Duration _slideDuration = Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _fadeDuration,
    )..addListener(() {
      // Reconstruye el widget para actualizar la opacidad en AnimatedBuilder
      setState(() {});
    });
    
    // Inicia el slideshow inmediatamente después de que el controlador esté listo
    _controller.forward(from: 0.0);
    _startSlideshowTimer(); 
  }

  void _startSlideshowTimer() {
    // 🚨 Mejor práctica: Usar Timer.periodic o Timer simple recurrente
    _slideshowTimer?.cancel(); // Cancela cualquier timer existente
    
    _slideshowTimer = Timer(_slideDuration, () {
      if (!mounted) {
        // Detiene la ejecución si el widget ya no está montado (seguridad)
        _slideshowTimer?.cancel();
        return;
      }
      
      // 1. Actualiza los índices
      _previousIndex = _currentIndex;
      _currentIndex = (_currentIndex + 1) % images.length;
      
      // 2. Reinicia la animación de desvanecimiento
      _controller.forward(from: 0.0).then((_) {
        // 3. Cuando la animación termina, reinicia el Timer para el siguiente slide
        _startSlideshowTimer();
      });

      // Se usa setState() para actualizar los índices en el frame de la animación
      setState(() {});
    });
  }

  @override
  void dispose() {
    _slideshowTimer?.cancel(); // 🚨 Importante: Cancelar el Timer
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink(); // No mostrar nada si no hay imágenes
    }
    
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Usa LayoutBuilder para decidir el AspectRatio/Height según el ancho disponible
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        // Contenido del slider
        Widget sliderContent = Stack(
          fit: StackFit.expand,
          children: [
            // 1. IMAGEN ANTERIOR (como base fija)
            Image.asset(
              images[_previousIndex],
              fit: BoxFit.cover, 
              key: ValueKey<int>(_previousIndex),
              // Manejo de errores de imagen básico
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[800]),
            ),

            // 2. IMAGEN ACTUAL (animada con opacidad)
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Opacity(
                  opacity: animation.value,
                  child: Image.asset(
                    images[_currentIndex],
                    fit: BoxFit.cover,
                    key: ValueKey<int>(_currentIndex + 100),
                    // Manejo de errores de imagen básico
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[700]),
                  ),
                );
              },
            ),
          ],
        );

        // 3. Aplicación de AspectRatio o altura fija
        if (isMobile) {
          // En MÓVIL: AspectRatio 1:1 (cuadrado)
          return AspectRatio(
            aspectRatio: 1.0, 
            child: sliderContent,
          );
        } else {
          // En ESCRITORIO/TABLETA: Si el padre no impone una altura (maxHeight.isFinite), usar 400.
          return SizedBox(
            height: constraints.maxHeight.isFinite ? constraints.maxHeight : 450, // Aumenté a 450 para mejor visualización
            child: sliderContent,
          );
        }
      },
    );
  }
}