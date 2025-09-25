// Archivo: lib/hero.dart

import 'package:flutter/material.dart';
import 'translations.dart';
import 'video_player.dart';

class HeroSection extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;

  const HeroSection({super.key, required this.languageNotifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder<String>(
        valueListenable: languageNotifier,
        builder: (context, language, _) {
          final heroText = appTranslations[language]!;
          final isDesktop = MediaQuery.of(context).size.width > 1200;
          if (isDesktop) {
            return _buildDesktopHeroSection(heroText);
          } else {
            return _buildMobileHeroSection(heroText);
          }
        },
      ),
    );
  }

  Widget _buildDesktopHeroSection(Map<String, dynamic> heroText) {
    // Forzamos la Card a ocupar todo el ancho disponible.
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // Eliminamos mainAxisSize.min para que la fila se expanda.
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 64.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heroText['hero_title'],
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        heroText['hero_subtitle'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 48.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color.fromRGBO(0, 0, 0, 0.5),
                            Color.fromRGBO(0, 0, 0, 0.5),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.1, 0.9, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: const SizedBox(
                        height: 400,
                        child: CustomVideoPlayer(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileHeroSection(Map<String, dynamic> heroText) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromRGBO(0, 0, 0, 0.5),
                      Color.fromRGBO(0, 0, 0, 0.5),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.1, 0.9, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: const SizedBox(
                  height: 400,
                  child: CustomVideoPlayer(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    heroText['hero_title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    heroText['hero_subtitle'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}