import 'package:flutter/material.dart';

class AnimatedRoute {
  static Route<T> slideFade<T>(Widget page) {
    return PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: 550),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        final offset = Tween<Offset>(
          begin: const Offset(0.12, 0.08),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offset,
            child: child,
          ),
        );
      },
    );
  }
}