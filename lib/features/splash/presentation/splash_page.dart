import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:toolbox_app/features/home/presentation/pages/home_page.dart';

import '../../../../core/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _glowController;

  final List<String> _boxImages = const [
    'assets/images/closetoolbox.png',
    'assets/images/toolboxclose15.png',
    'assets/images/toolboxclose30.png',
    'assets/images/fulltoolbox.png',
    'assets/images/toolboxclose30.png',
    'assets/images/toolboxclose15.png',
    'assets/images/closetoolbox.png',
  ];

  final List<String> _tools = const [
    'assets/images/toolone.png',
    'assets/images/tooltwo.png',
    'assets/images/toolthree.png',
    'assets/images/toolfour.png',
    'assets/images/toolfive.png',
    'assets/images/toolsix.png',
    'assets/images/toolseven.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8500),
    )..forward();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 8800), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _glowController.dispose();
    super.dispose();
  }

  int get _boxIndex {
    final value = (_controller.value * _boxImages.length).floor();
    return value.clamp(0, _boxImages.length - 1);
  }

  Widget _background() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        final pulse = math.sin(_glowController.value * math.pi * 2).abs();

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, .10),
              radius: 1.25,
              colors: [
                AppTheme.electricBlue.withOpacity(.22 + pulse * .14),
                const Color(0xFF071A2D),
                const Color(0xFF02040A),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _toolSavingAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 160,
              left: 20,
              right: 20,
              child: Image.asset(
                _boxImages[_boxIndex],
                height: 230,
                fit: BoxFit.contain,
              ),
            ),

            ...List.generate(_tools.length, (index) {
              final start = index / 9;
              final end = start + .22;

              final progress = ((_controller.value - start) / (end - start))
                  .clamp(0.0, 1.0);

              final curved = Curves.easeInOutCubic.transform(progress);

              final startX = -150.0 + (index * 50);
              final startY = 520.0;

              final endX = 0.0;
              final endY = 300.0;

              final x = startX + ((endX - startX) * curved);
              final y = startY + ((endY - startY) * curved);

              final opacity = (1 - curved).clamp(0.0, 1.0);
              final scale = 1.2 - (.55 * curved);

              return Transform.translate(
                offset: Offset(x, y - 360),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Image.asset(
                      _tools[index],
                      width: 82,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }),

            Positioned(
              bottom: 120,
              left: 40,
              right: 40,
              child: Column(
                children: [
                  const Text(
                    'Magic Toolbox',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Guardando herramientas mágicas...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.pearlGray.withOpacity(.82),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          _toolSavingAnimation(),
        ],
      ),
    );
  }
}