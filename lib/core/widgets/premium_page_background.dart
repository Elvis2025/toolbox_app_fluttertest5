import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PremiumPageBackground extends StatelessWidget {
  final Widget child;

  const PremiumPageBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.navy,
                AppTheme.darkBlue,
                Color(0xFF111827),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned(
          top: 90,
          right: -40,
          child: Icon(
            Icons.construction_rounded,
            size: 190,
            color: Colors.white.withOpacity(0.035),
          ),
        ),

        Positioned(
          bottom: 80,
          left: -30,
          child: Icon(
            Icons.auto_awesome_rounded,
            size: 160,
            color: Colors.white.withOpacity(0.04),
          ),
        ),

        child,
      ],
    );
  }
}