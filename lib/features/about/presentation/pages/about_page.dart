import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Widget _contactTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withOpacity(.07),
        border: Border.all(color: Colors.white.withOpacity(.14)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.electricBlue.withOpacity(.18),
            ),
            child: Icon(icon, color: AppTheme.electricBlue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.pearlGray.withOpacity(.72),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoProfile() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .85, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final pulse = _pulseController.value;
          final blur = 24 + (pulse * 28);
          final spread = 1 + (pulse * 5);

          return Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppTheme.electricBlue,
                  Color(0xFF7FDBFF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.electricBlue.withOpacity(.35 + pulse * .28),
                  blurRadius: blur,
                  spreadRadius: spread,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: child,
          );
        },
        child: const CircleAvatar(
          radius: 82,
          backgroundColor: AppTheme.cardDark,
          backgroundImage: AssetImage('assets/images/elvis.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PremiumPageBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Center(child: _photoProfile()),

              const SizedBox(height: 24),

              const Text(
                'Elvis Jesús Hernández Suárez',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Desarrollador de Software',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.pearlGray.withOpacity(.82),
                ),
              ),

              const SizedBox(height: 28),

              _contactTile(
                icon: Icons.email_rounded,
                title: 'Correo',
                value: 'inelvis16031124@gmail.com',
              ),
              _contactTile(
                icon: Icons.phone_rounded,
                title: 'Teléfono',
                value: '+1 849-869-8664',
              ),
              _contactTile(
                icon: Icons.link_rounded,
                title: 'Portafolio',
                value: 'GitHub / LinkedIn / Portafolio',
              ),
            ],
          ),
        ),
      ),
    );
  }
}