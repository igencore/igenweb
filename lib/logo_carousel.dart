// Archivo: lib/logo_carousel.dart (Limpiado y Final)

import 'package:flutter/material.dart';

class LogoCarousel extends StatefulWidget {
  const LogoCarousel({super.key});

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
  
  // Usamos un número alto para que el ListView parezca infinito
  static const int itemCount = 1000; 

  // Constantes de dimensiones
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
    
    // Calcula el ancho de un solo loop para la traslación.
    final double singleLoopWidth = originalLogoPaths.length * logoFullEstimatedWidth;
    
    // La animación mueve la posición de scroll.
    _animationController.addListener(() {
      if (!_scrollController.hasClients) return;
      
      // Calculamos la posición de scroll basada en el valor de la animación (0.0 a 1.0)
      // La animación debe ir de 0 al ancho de un solo loop.
      double scrollPosition = _animationController.value * singleLoopWidth;
      
      // Si la posición calculada se acerca al final del primer loop,
      // la reiniciamos suavemente al inicio para un efecto continuo.
      // Usamos el módulo (%) para garantizar el loop infinito continuo.
      scrollPosition = scrollPosition % singleLoopWidth;
      
      // Intentar saltar a la nueva posición.
      if (_scrollController.hasClients) {
          _scrollController.jumpTo(scrollPosition);
      }
    });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        // Obtenemos el ancho visible disponible
        final double screenWidth = constraints.maxWidth;
        
        // Eliminamos el NotificationListener ya que _isScrollingByUser fue eliminado.
        return Center(
          child: SizedBox(
            width: screenWidth, // Contenedor que define el área visible
            height: logoMaxHeight, 
            
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              // Deshabilitamos el scroll manual para que solo la animación lo mueva.
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: itemCount, 
              
              itemBuilder: (context, index) {
                // Obtenemos el logo de la lista original usando el módulo (%)
                final path = originalLogoPaths[index % originalLogoPaths.length];
                
                final logoColor = Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(77); 

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: logoHorizontalPadding),
                  
                  child: Container( 
                    height: logoMaxHeight, 
                    width: logoEstimatedWidth, // Ancho fijo para que el ListView sepa su tamaño
                    alignment: Alignment.center,
                    
                    child: Image.asset(
                      path,
                      fit: BoxFit.fitHeight, // Permite proporciones variables dentro del ancho fijo
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