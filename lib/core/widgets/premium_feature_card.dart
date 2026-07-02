import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PremiumFeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const PremiumFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<PremiumFeatureCard> createState() => _PremiumFeatureCardState();
}

class _PremiumFeatureCardState extends State<PremiumFeatureCard> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 180),
      child: GestureDetector(
        onTapDown: (_) => setState(() => scale = .96),
        onTapCancel: () => setState(() => scale = 1),
        onTapUp: (_) {
          setState(() => scale = 1);
          widget.onTap();
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF13243A),
                Color(0xFF0D1B2E),
              ],
            ),
            border: Border.all(
              color: Colors.white24,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.electricBlue.withOpacity(.18),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.electricBlue.withOpacity(.18),
                ),
                child: Icon(
                  widget.icon,
                  color: AppTheme.electricBlue,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: AppTheme.pearlGray.withOpacity(.75),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}