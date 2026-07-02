import 'package:flutter/material.dart';

import '../services/sound_service.dart';
import '../theme/app_theme.dart';

class PremiumPageBackground extends StatefulWidget {
  final Widget child;

  const PremiumPageBackground({
    super.key,
    required this.child,
  });

  @override
  State<PremiumPageBackground> createState() => _PremiumPageBackgroundState();
}

class _PremiumPageBackgroundState extends State<PremiumPageBackground> {
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

        widget.child,

        Positioned(
          top: 44,
          right: 16,
          child: ValueListenableBuilder<bool>(
            valueListenable: SoundService.soundEnabled,
            builder: (context, enabled, _) {
              return GestureDetector(
                onTap: () async {
                  await SoundService.toggleSound();
                  setState(() {});
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(.08),
                    border: Border.all(
                      color: Colors.white.withOpacity(.16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.electricBlue.withOpacity(
                          enabled ? .35 : .08,
                        ),
                        blurRadius: enabled ? 22 : 8,
                        spreadRadius: enabled ? 2 : 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    enabled
                        ? Icons.volume_up_rounded
                        : Icons.volume_off_rounded,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}