import 'package:flutter/material.dart';

class MagicToolRoute<T> extends PageRouteBuilder<T> {
  MagicToolRoute({
    required Widget page,
    required String toolImage,
  }) : super(
          transitionDuration: const Duration(milliseconds: 1400),
          reverseTransitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return FadeTransition(
              opacity: curved,
              child: child,
            );
          },
        );
}