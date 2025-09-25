// Archivo: lib/video_player.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Un widget para reproducir videos con controles básicos.
class CustomVideoPlayer extends StatefulWidget {
  final bool shouldAutoplay;

  const CustomVideoPlayer({
    super.key,
    this.shouldAutoplay = true,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://res.cloudinary.com/dial3sreb/video/upload/v1758777722/hero1_nwy7y0.webm'),
    )..initialize().then((_) {
        if (!mounted) {
          return;
        }
        _controller.setVolume(0);
        if (widget.shouldAutoplay) {
          _controller.play();
        }
        setState(() {});
      });

    _controller.addListener(() {
      if (!mounted) {
        return;
      }
      if (_controller.value.position >= _controller.value.duration) {
        _controller.seekTo(Duration.zero);
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos ValueListenableBuilder para escuchar el estado del controlador
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: _controller,
      builder: (context, value, child) {
        if (!value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        // El FittedBox ahora se construye solo cuando el video está inicializado
        return FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: value.size.width,
            height: value.size.height,
            child: VideoPlayer(_controller),
          ),
        );
      },
    );
  }
}