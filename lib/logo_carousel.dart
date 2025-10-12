// Archivo: lib/logo_carousel.dart

import 'package:flutter/material.dart';

class LogoCarousel extends StatefulWidget {
  const LogoCarousel({super.key});

  @override
  State<LogoCarousel> createState() => _LogoCarouselState();
}

class _LogoCarouselState extends State<LogoCarousel> {
  final ScrollController _scrollController = ScrollController();
  
  // Lista de logos (sin cambios)
  final List<String> logoPaths = [
    'assets/images/logos/logo1.png',
    'assets/images/logos/logo2.png',
    'assets/images/logos/logo3.png',
    'assets/images/logos/logo4.png',
    'assets/images/logos/logo5.png',
    'assets/images/logos/logo1.png',
    'assets/images/logos/logo2.png',
    'assets/images/logos/logo3.png',
    'assets/images/logos/logo4.png',
    'assets/images/logos/logo5.png',
    'assets/images/logos/logo1.png',
    'assets/images/logos/logo2.png',
    'assets/images/logos/logo3.png',
    'assets/images/logos/logo4.png',
    'assets/images/logos/logo5.png',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    const duration = Duration(seconds: 30); 
    
    if (!_scrollController.hasClients || _scrollController.position.maxScrollExtent == 0) {
      Future.delayed(const Duration(milliseconds: 50), () => _startScrolling());
      return;
    }

    final double maxScroll = _scrollController.position.maxScrollExtent;

    _scrollController.animateTo(
      maxScroll,
      duration: duration,
      curve: Curves.linear,
    ).then((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0.0);
        _startScrolling();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900; 
    
    // Altura máxima para los logos (80px * 0.7 = 56px)
    const logoMaxHeight = 56.0; 
    
    // ANCHO ESTIMADO AJUSTADO: Usamos 110px para un logo, más padding
    const logoEstimatedWidth = 110.0;
    const logoHorizontalPadding = 24.0; 
    const logoFullEstimatedWidth = logoEstimatedWidth + (logoHorizontalPadding * 2); // 158.0

    // CÁLCULO DEL ANCHO MÁXIMO DEL CARRUSEL SEGÚN EL DISPOSITIVO
    double maxCarouselWidth;
    if (isDesktop) {
        maxCarouselWidth = 1000.0; 
    } else if (screenWidth > 600) { 
        // Tablet: Límite para 4 logos (usando el ancho estimado)
        maxCarouselWidth = 4 * logoFullEstimatedWidth; // 4 * 158 = 632.0
    } else {
        // Móvil: Límite para 3 logos (usando el ancho estimado)
        maxCarouselWidth = 3 * logoFullEstimatedWidth; // 3 * 158 = 474.0
    }

    // Calculamos el ancho del fade (5% del maxCarouselWidth)
    final fadeWidth = maxCarouselWidth * 0.05; 
    
    final shaderMask = ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).scaffoldBackgroundColor, 
            Colors.transparent, 
            Colors.transparent,
            Theme.of(context).scaffoldBackgroundColor, 
          ],
          // Stops dinámicos
          stops: [0.0, fadeWidth / bounds.width, 1.0 - (fadeWidth / bounds.width), 1.0], 
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut, 
      
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxCarouselWidth), 
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: logoMaxHeight), // <--- ALTURA AJUSTADA A 56px
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: logoPaths.length,
            itemBuilder: (context, index) {
              final logoColor = Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withAlpha(77); 

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: logoHorizontalPadding),
                child: Image.asset(
                  logoPaths[index],
                  fit: BoxFit.fitHeight, 
                  color: logoColor, 
                ),
              );
            },
          ),
        ),
      ),
    );

    return Center(
      child: shaderMask,
    );
  }
}