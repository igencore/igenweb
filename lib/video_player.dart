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
    _controller = VideoPlayerController.asset(
      'assets/videos/hero1.webm',
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
    if (_controller.value.isInitialized) {
      return FittedBox(
        fit: BoxFit.cover, // Esto asegura que el video cubra el espacio sin distorsión
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}