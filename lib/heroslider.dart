// Archivo: lib/heroslider.dart

import 'package:flutter/material.dart';

class HeroSlider extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
      setState(() {});
    });
    _startSlideshow();
  }

  void _startSlideshow() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      
      _previousIndex = _currentIndex;
      
      setState(() {
        _currentIndex = (_currentIndex + 1) % images.length;
      });

      _controller.forward(from: 0.0).then((_) {
        _controller.value = 1.0; 
        _startSlideshow();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // La animación va de 0.0 a 1.0 durante 1.5 segundos
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // 1. Usamos LayoutBuilder para obtener las restricciones de ancho (maxWidth)
    return LayoutBuilder(
      builder: (context, constraints) {
        // En HeroSection.dart, el punto de quiebre para móvil es 1000.
        // Aquí, usamos un punto de quiebre similar, pero basándonos en el ancho
        // disponible para el HeroSlider. Generalmente, un ancho disponible bajo
        // (ej. < 600) indica un dispositivo móvil.
        final isMobile = constraints.maxWidth < 600;
        
        // 2. Definimos la altura o AspectRatio condicionalmente
        Widget sliderContent = Stack(
          fit: StackFit.expand,
          children: [
            // 1. IMAGEN ANTERIOR
            Image.asset(
              images[_previousIndex],
              fit: BoxFit.cover, 
              key: ValueKey<int>(_previousIndex),
            ),

            // 2. IMAGEN ACTUAL
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Opacity(
                  opacity: animation.value,
                  child: Image.asset(
                    images[_currentIndex],
                    fit: BoxFit.cover,
                    key: ValueKey<int>(_currentIndex + 100),
                  ),
                );
              },
            ),
          ],
        );

        if (isMobile) {
          // 3. En MÓVIL: Forzar relación 1:1 (cuadrado)
          // Usamos AspectRatio, y su altura será determinada por el ancho disponible.
          return AspectRatio(
            aspectRatio: 1.0, // 1:1
            child: sliderContent,
          );
        } else {
          // 4. En ESCRITORIO/TABLETA: Mantener la altura fija definida por el padre (HeroSection.dart)
          return SizedBox(
            height: constraints.maxHeight.isFinite ? constraints.maxHeight : 400, // Usar 400 si el padre no la impone
            child: sliderContent,
          );
        }
      },
    );
  }
}