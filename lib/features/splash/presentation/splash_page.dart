import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../core/services/sound_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_shell.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController boxController;
  late final AnimationController toolController;
  late final AnimationController glowController;

  Timer? _toolTimer;
  int currentToolIndex = 0;
  bool toolsStarted = false;

  final tools = const [
    'assets/images/toolone.png',
    'assets/images/tooltwo.png',
    'assets/images/toolthree.png',
    'assets/images/toolfour.png',
    'assets/images/toolfive.png',
    'assets/images/toolsix.png',
    'assets/images/toolseven.png',
  ];

  static const int boxOpenDurationMs = 3200;
  static const int waitAfterOpenMs = 900;
  static const int toolDurationMs = 2700;

  @override
  void initState() {
    super.initState();

    SoundService.playMagicLoop();

    boxController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: boxOpenDurationMs),
    );

    toolController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: toolDurationMs),
    );

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    boxController.forward();

    Future.delayed(
      const Duration(milliseconds: boxOpenDurationMs + waitAfterOpenMs),
      () {
        if (!mounted) return;

        setState(() {
          toolsStarted = true;
          currentToolIndex = 0;
        });

        SoundService.playToolEnter();
        toolController.forward(from: 0);

        _toolTimer = Timer.periodic(
          const Duration(milliseconds: toolDurationMs),
          (timer) {
            if (!mounted) return;

            if (currentToolIndex < tools.length - 1) {
              setState(() => currentToolIndex++);
              SoundService.playToolEnter();
              toolController.forward(from: 0);
            } else {
              timer.cancel();

              Future.delayed(const Duration(milliseconds: 650), () async {
                if (!mounted) return;

                await SoundService.stopMagicLoop();

                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 900),
                    pageBuilder: (_, __, ___) => const AppShell(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              });
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _toolTimer?.cancel();
    boxController.dispose();
    toolController.dispose();
    glowController.dispose();
    super.dispose();
  }

  String _openingBoxImage(double progress) {
    if (progress < .25) return 'assets/images/closetoolbox.png';
    if (progress < .50) return 'assets/images/toolboxclose15.png';
    if (progress < .75) return 'assets/images/toolboxclose30.png';
    return 'assets/images/voidtoolbox.png';
  }

  String _savingBoxImage(double progress) {
    if (progress < .68) return 'assets/images/voidtoolbox.png';
    if (progress < .78) return 'assets/images/toolboxclose30.png';
    if (progress < .90) return 'assets/images/toolboxclose15.png';
    return 'assets/images/closetoolbox.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          boxController,
          toolController,
          glowController,
        ]),
        builder: (context, _) {
          final glow = math.sin(glowController.value * math.pi * 2).abs();

          final boxImage = toolsStarted
              ? _savingBoxImage(toolController.value)
              : _openingBoxImage(boxController.value);

          final progress = toolController.value;

          final move = Curves.easeInOutCubic.transform(
            (progress / .68).clamp(0.0, 1.0),
          );

          final toolOpacity = progress < .78
              ? 1.0
              : (1 - ((progress - .78) / .22)).clamp(0.0, 1.0);

          final startY = 535.0;
          final endY = 315.0;
          final currentY = startY + ((endY - startY) * move);

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, .12),
                    radius: 1.25,
                    colors: [
                      AppTheme.electricBlue.withOpacity(.22 + glow * .16),
                      const Color(0xFF071A2D),
                      const Color(0xFF02040A),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 230,
                child: Image.asset(
                  boxImage,
                  width: MediaQuery.of(context).size.width * 1.08,
                  fit: BoxFit.contain,
                ),
              ),
              if (toolsStarted)
                Positioned(
                  top: currentY,
                  child: Opacity(
                    opacity: toolOpacity,
                    child: Transform.scale(
                      scale: 1.45 - (.55 * move),
                      child: Image.asset(
                        tools[currentToolIndex],
                        width: 150,
                        height: 210,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              const Positioned(
                bottom: 88,
                left: 30,
                right: 30,
                child: Text(
                  'Magic Toolbox',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}