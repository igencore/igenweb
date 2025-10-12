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
  // Usaremos un índice para rastrear la imagen que se desvanece
  int _previousIndex = 0; 

  @override
  void initState() {
    super.initState();
    // Duración total de cada slide (incluye el tiempo de transición)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Duración total de la transición
    )..addListener(() {
      setState(() {});
    });

    // Inicia el cambio de imagen cada 4 segundos
    _startSlideshow();
  }

  void _startSlideshow() {
    // Definimos un timer para cambiar la imagen cada 4 segundos (incluyendo la transición)
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      
      // 1. Guardar el índice actual como el índice anterior
      _previousIndex = _currentIndex;
      
      // 2. Moverse al siguiente índice
      setState(() {
        _currentIndex = (_currentIndex + 1) % images.length;
      });

      // 3. Reiniciar el controlador para que la nueva imagen se fusione
      _controller.forward(from: 0.0).then((_) {
        // Cuando la fusión termine, pausar la animación
        // y comenzar el timer para el próximo cambio
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

    return SizedBox(
      height: 400,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. IMAGEN ANTERIOR (Base, Opacidad 1.0)
          // Se mantiene visible hasta que la nueva la cubre.
          Image.asset(
            images[_previousIndex],
            fit: BoxFit.cover, 
            key: ValueKey<int>(_previousIndex), // Clave para forzar la actualización
          ),

          // 2. IMAGEN ACTUAL (Se fusiona encima, Opacidad 0.0 -> 1.0)
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: animation.value, // Opacidad animada: 0.0 (transparente) a 1.0 (opaca)
                child: Image.asset(
                  images[_currentIndex],
                  fit: BoxFit.cover,
                  key: ValueKey<int>(_currentIndex + 100), // Clave diferente
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}