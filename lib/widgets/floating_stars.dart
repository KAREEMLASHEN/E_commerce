import 'dart:math';
import 'package:flutter/material.dart';

class FloatingStars extends StatefulWidget {
  const FloatingStars({super.key});

  @override
  State<FloatingStars> createState() => _FloatingStarsState();
}

class _FloatingStarsState extends State<FloatingStars>
    with TickerProviderStateMixin {
  late List<_Star> _stars;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    final random = Random();
    _stars = List.generate(30, (i) => _Star(
      size: random.nextDouble() * 3 + 2,
      x: random.nextDouble(),
      y: random.nextDouble(),
      delay: random.nextDouble() * 5,
      duration: random.nextDouble() * 3 + 2,
    ));

    _controllers = _stars.map((star) => AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (star.duration * 1000).toInt()),
    )).toList();

    _animations = _controllers.map((c) =>
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      )).toList();

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(
        Duration(milliseconds: (_stars[i].delay * 1000).toInt()),
        () {
          if (mounted) _controllers[i].repeat(reverse: true);
        },
      );
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final starColor = isDark ? Colors.white : const Color(0xFF2563EB);
    final opacity = isDark ? 0.6 : 0.8;

    return Stack(
      children: List.generate(_stars.length, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (context, child) {
            return Positioned(
              left: _stars[i].x * MediaQuery.of(context).size.width,
              top: _stars[i].y * MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: _animations[i].value * opacity,
                child: Transform.scale(
                  scale: _animations[i].value,
                  child: Container(
                    width: _stars[i].size,
                    height: _stars[i].size,
                    decoration: BoxDecoration(
                      color: starColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _Star {
  final double size;
  final double x;
  final double y;
  final double delay;
  final double duration;

  _Star({
    required this.size,
    required this.x,
    required this.y,
    required this.delay,
    required this.duration,
  });
}