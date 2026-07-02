import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/navigation/magic_tool_route.dart';
import '../../../../core/theme/app_theme.dart';

import '../../../about/presentation/pages/about_page.dart';
import '../../../age/presentation/age_page.dart';
import '../../../gender/presentation/gender_page.dart';
import '../../../news/presentation/news_page.dart';
import '../../../pokemon/presentation/pokemon_page.dart';
import '../../../universities/presentation/university_page.dart';
import '../../../weather/presentation/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _boxStage = 0;
  bool _toolSelected = false;
  _MagicTool? _selectedTool;

  final List<Timer> _timers = [];

  late final AnimationController _glowController;
  late final AnimationController _floatController;
  late final AnimationController _toolExitController;

  static const int _boxStepDuration = 3000;

  final List<String> _boxImages = const [
    'assets/images/closetoolbox.png',
    'assets/images/toolboxclose15.png',
    'assets/images/toolboxclose30.png',
    'assets/images/fulltoolbox.png',
  ];

  late final List<_MagicTool> _tools = [
    _MagicTool('Género', 'assets/images/toolone.png', const GenderPage()),
    _MagicTool('Edad', 'assets/images/tooltwo.png', const AgePage()),
    _MagicTool('Universidades', 'assets/images/toolthree.png', const UniversityPage()),
    _MagicTool('Clima RD', 'assets/images/toolfour.png', const WeatherPage()),
    _MagicTool('Pokémon', 'assets/images/toolfive.png', const PokemonPage()),
    _MagicTool('Noticias', 'assets/images/toolsix.png', const NewsPage()),
    _MagicTool('Acerca de', 'assets/images/toolseven.png', const AboutPage()),
  ];

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _toolExitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _startBoxOpening();
  }

  void _startBoxOpening() {
    _timers.add(
      Timer(const Duration(milliseconds: 4200), () {
        if (mounted) setState(() => _boxStage = 1);
      }),
    );

    _timers.add(
      Timer(const Duration(milliseconds: 4200 + _boxStepDuration), () {
        if (mounted) setState(() => _boxStage = 2);
      }),
    );

    _timers.add(
      Timer(const Duration(milliseconds: 4200 + (_boxStepDuration * 2)), () {
        if (mounted) setState(() => _boxStage = 3);
      }),
    );
  }

  @override
  void dispose() {
    for (final timer in _timers) {
      timer.cancel();
    }

    _glowController.dispose();
    _floatController.dispose();
    _toolExitController.dispose();
    super.dispose();
  }

  Future<void> _selectTool(_MagicTool tool) async {
    if (_toolSelected || _boxStage != 3) return;

    setState(() {
      _selectedTool = tool;
      _toolSelected = true;
    });

    _toolExitController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 2100));

    if (!mounted) return;

    await Navigator.push(
      context,
      MagicToolRoute(
        page: tool.page,
        toolImage: tool.image,
      ),
    );

    if (!mounted) return;

    _toolExitController.reverse(from: 1);

    await Future.delayed(const Duration(milliseconds: 850));

    if (mounted) {
      setState(() {
        _toolSelected = false;
        _selectedTool = null;
      });
    }
  }

  Widget _background() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        final pulse = math.sin(_glowController.value * math.pi * 2).abs();

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(.20, .20),
              radius: 1.18,
              colors: [
                AppTheme.electricBlue.withOpacity(.24 + pulse * .10),
                const Color(0xFF071A2D),
                const Color(0xFF02040A),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _platform() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        return Align(
          alignment: const Alignment(.15, .58),
          child: Transform.rotate(
            angle: _glowController.value * math.pi * 2,
            child: Container(
              width: 520,
              height: 520,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    Colors.transparent,
                    AppTheme.electricBlue.withOpacity(.72),
                    Colors.purpleAccent.withOpacity(.52),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _lightBeam() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        final pulse = math.sin(_glowController.value * math.pi * 2).abs();

        return Align(
          alignment: const Alignment(.15, -.05),
          child: Container(
            width: 360 + pulse * 110,
            height: 670,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.electricBlue.withOpacity(.08 + pulse * .12),
                  Colors.white.withOpacity(.06 + pulse * .09),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _toolboxScene() {
    if (_toolSelected) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, _) {
        final floating = math.sin(_floatController.value * math.pi) * 8;
        final screenWidth = MediaQuery.of(context).size.width;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(0, -floating),
              child: Transform.rotate(
                angle: .035,
                child: SizedBox(
                  width: screenWidth,
                  height: 245,
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: _boxStepDuration),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeInCubic,
                      child: Image.asset(
                        _boxImages[_boxStage],
                        key: ValueKey(_boxStage),
                        width: screenWidth * 1.36,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            if (_boxStage == 3)
              Transform.translate(
                offset: const Offset(0, -18),
                child: SizedBox(
                  width: screenWidth,
                  height: 360,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: List.generate(4, (index) {
                            return Expanded(
                              child: Center(
                                child: _ToolImageButton(
                                  tool: _tools[index],
                                  index: index,
                                  floatController: _floatController,
                                  onTap: () => _selectTool(_tools[index]),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -32),
                        child: SizedBox(
                          height: 180,
                          child: Row(
                            children: [
                              const Spacer(flex: 1),
                              ...List.generate(3, (i) {
                                final index = i + 4;
                                return Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: _ToolImageButton(
                                      tool: _tools[index],
                                      index: index,
                                      floatController: _floatController,
                                      onTap: () => _selectTool(_tools[index]),
                                    ),
                                  ),
                                );
                              }),
                              const Spacer(flex: 1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _selectedToolAnimation() {
    if (_selectedTool == null) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _toolExitController,
      builder: (context, _) {
        final value = Curves.easeOutExpo.transform(_toolExitController.value);
        final fade = (1 - value).clamp(0.0, 1.0);

        return IgnorePointer(
          child: Stack(
            children: [
              Container(color: Colors.black.withOpacity(.78 * value)),
              Center(
                child: Opacity(
                  opacity: fade,
                  child: Transform.scale(
                    scale: .18 + value * 4.1,
                    child: Image.asset(
                      _selectedTool!.image,
                      width: 360,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _title() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        final pulse = math.sin(_glowController.value * math.pi * 2).abs();

        return Text(
          'Magic Toolbox',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                color: AppTheme.electricBlue.withOpacity(.7 + pulse * .3),
                blurRadius: 22 + pulse * 18,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          _background(),
          _lightBeam(),
          _platform(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Center(child: _title()),
                  SizedBox(height: height < 720 ? 2 : 8),
                  Expanded(
                    child: Center(
                      child: _toolboxScene(),
                    ),
                  ),
                  Text(
                    'Made by Elvis Hernández',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.70),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          if (_toolSelected) _selectedToolAnimation(),
        ],
      ),
    );
  }
}

class _ToolImageButton extends StatefulWidget {
  final _MagicTool tool;
  final int index;
  final VoidCallback onTap;
  final AnimationController floatController;

  const _ToolImageButton({
    required this.tool,
    required this.index,
    required this.onTap,
    required this.floatController,
  });

  @override
  State<_ToolImageButton> createState() => _ToolImageButtonState();
}

class _ToolImageButtonState extends State<_ToolImageButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 1600 + widget.index * 380),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: Transform.scale(
              scale: .22 + (.78 * value),
              child: child,
            ),
          ),
        );
      },
      child: AnimatedBuilder(
        animation: widget.floatController,
        builder: (context, child) {
          final move = math.sin(
                widget.floatController.value * math.pi * 2 +
                    widget.index * .7,
              ) *
              8;

          final rotate = math.sin(
                widget.floatController.value * math.pi * 2 +
                    widget.index,
              ) *
              .04;

          return Transform.translate(
            offset: Offset(0, move),
            child: Transform.rotate(
              angle: rotate,
              child: child,
            ),
          );
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? .90 : 1,
            duration: const Duration(milliseconds: 160),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 126,
              height: 172,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _pressed
                    ? AppTheme.electricBlue.withOpacity(.20)
                    : Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.electricBlue.withOpacity(
                      _pressed ? .88 : .38,
                    ),
                    blurRadius: _pressed ? 52 : 36,
                    spreadRadius: _pressed ? 10 : 5,
                  ),
                ],
              ),
              child: Image.asset(
                widget.tool.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MagicTool {
  final String title;
  final String image;
  final Widget page;

  const _MagicTool(this.title, this.image, this.page);
}