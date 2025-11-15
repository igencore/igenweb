// Archivo: lib/logo_carousel.dart (FINAL: CON PAUSA POR SCROLL)

import 'package:flutter/material.dart';

class LogoCarousel extends StatefulWidget {
  // 🚨 NUEVO: Notificador para recibir el estado de pausa desde el padre
  final ValueNotifier<bool>? isPausedNotifier;

  const LogoCarousel({super.key, this.isPausedNotifier});

  @override
  State<LogoCarousel> createState() => _LogoCarouselState();
}

class _LogoCarouselState extends State<LogoCarousel> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  
  // Lista de logos: ahora es 'final'
  final List<String> originalLogoPaths = const [
    'assets/images/logos/logo1.png',
    'assets/images/logos/logo2.png',
    'assets/images/logos/logo3.png',
    'assets/images/logos/logo4.png',
    'assets/images/logos/logo5.png',
  ];
  
  static const int itemCount = 1000; 
  static const double logoMaxHeight = 56.0; 
  static const double logoEstimatedWidth = 110.0; 
  static const double logoHorizontalPadding = 24.0; 
  static const double logoFullEstimatedWidth = logoEstimatedWidth + (logoHorizontalPadding * 2); 

  @override
  void initState() {
    super.initState();
    
    _scrollController = ScrollController();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), 
    );
    
    // Calcula el ancho de un solo loop
    final double singleLoopWidth = originalLogoPaths.length * logoFullEstimatedWidth;
    
    // Listener principal de la animación
    _animationController.addListener(() {
      if (!_scrollController.hasClients) return;
      
      double scrollPosition = _animationController.value * singleLoopWidth;
      scrollPosition = scrollPosition % singleLoopWidth;
      
      if (_scrollController.hasClients) {
          _scrollController.jumpTo(scrollPosition);
      }
    });

    // 🚨 LÓGICA DE PAUSA
    if (widget.isPausedNotifier != null) {
      // Si el carrusel es inicializado y el padre dice que está pausado, lo detenemos.
      if (widget.isPausedNotifier!.value) {
        _animationController.stop();
      } else {
        _animationController.repeat();
      }
      
      // Agregamos el listener para manejar los cambios de pausa/reanudación
      widget.isPausedNotifier!.addListener(_handlePauseToggle);
    } else {
       // Si no se proporciona notificador, la animación corre por defecto.
      _animationController.repeat();
    }
  }
  
  // FUNCIÓN PARA DETENER/REANUDAR
  void _handlePauseToggle() {
    if (widget.isPausedNotifier == null) return;
    
    if (widget.isPausedNotifier!.value) {
      // True: Pausar
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    } else {
      // False: Reanudar
      if (!_animationController.isAnimating) {
        _animationController.repeat();
      }
    }
  }

  @override
  void dispose() {
    // 🚨 REMOVER LISTENER DE PAUSA
    if (widget.isPausedNotifier != null) {
      widget.isPausedNotifier!.removeListener(_handlePauseToggle);
    }
    
    _animationController.stop();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        
        return Center(
          child: SizedBox(
            width: screenWidth, 
            height: logoMaxHeight, 
            
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              // Deshabilitamos el scroll manual para que solo la animación lo mueva.
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: itemCount, 
              
              itemBuilder: (context, index) {
                final path = originalLogoPaths[index % originalLogoPaths.length];
                
                final logoColor = Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(77); 

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: logoHorizontalPadding),
                  
                  child: Container( 
                    height: logoMaxHeight, 
                    width: logoEstimatedWidth, 
                    alignment: Alignment.center,
                    
                    child: Image.asset(
                      path,
                      fit: BoxFit.fitHeight, 
                      color: logoColor, 
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}