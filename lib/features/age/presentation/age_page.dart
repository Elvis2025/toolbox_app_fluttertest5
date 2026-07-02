import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';
import 'age_view_model.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> with TickerProviderStateMixin {
  final controller = TextEditingController();

  late final AnimationController _pulseController;
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _consultAge(AgeViewModel vm) async {
    FocusScope.of(context).unfocus();
    await vm.predictAge(controller.text);
  }

  Widget _header() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        const Expanded(
          child: Text(
            'Determinar edad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }

  Widget _searchPanel(AgeViewModel vm) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulse = _pulseController.value;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(.07),
            border: Border.all(
              color: AppTheme.electricBlue.withOpacity(.22 + pulse * .22),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.electricBlue.withOpacity(.12 + pulse * .16),
                blurRadius: 22 + pulse * 18,
                spreadRadius: pulse * 2,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              final move = math.sin(_floatController.value * math.pi) * 9;

              return Transform.translate(
                offset: Offset(0, -move),
                child: child,
              );
            },
            child: const Icon(
              Icons.cake_rounded,
              size: 64,
              color: AppTheme.electricBlue,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Predicción de edad',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Escribe un nombre y la app estimará su edad usando una API externa.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.pearlGray.withOpacity(.82),
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 18),

          TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _consultAge(vm),
            decoration: InputDecoration(
              labelText: 'Nombre',
              prefixIcon: const Icon(Icons.person_search_rounded),
              filled: true,
              fillColor: Colors.white.withOpacity(.08),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: vm.loading ? null : () => _consultAge(vm),
              icon: const Icon(Icons.auto_awesome_rounded),
              label: const Text(
                'Consultar edad',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingCard() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, _) {
        final pulse = _pulseController.value;

        return Container(
          margin: const EdgeInsets.only(top: 18),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                AppTheme.electricBlue.withOpacity(.18 + pulse * .10),
                Colors.white.withOpacity(.06),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(.14)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.electricBlue.withOpacity(.18 + pulse * .18),
                blurRadius: 24 + pulse * 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Transform.rotate(
                angle: pulse * math.pi * 2,
                child: const Icon(
                  Icons.hourglass_bottom_rounded,
                  size: 54,
                  color: AppTheme.electricBlue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Consultando edad...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Analizando el nombre con Agify.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.pearlGray.withOpacity(.78),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _resultCard(AgeViewModel vm) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .78, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0, 1),
          child: Transform.scale(scale: value, child: child),
        );
      },
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          final move = math.sin(_floatController.value * math.pi) * 8;

          return Transform.translate(
            offset: Offset(0, -move),
            child: child,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 18),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                AppTheme.electricBlue.withOpacity(.26),
                Colors.white.withOpacity(.07),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(.16)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.electricBlue.withOpacity(.25),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                vm.icon,
                size: 82,
                color: AppTheme.electricBlue,
              ),
              const SizedBox(height: 8),
              Text(
                '${vm.result!.age} años',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Estado: ${vm.category}',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.pearlGray.withOpacity(.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AgeViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PremiumPageBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: constraints.maxHeight < 720
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(22),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      _header(),
                      const SizedBox(height: 18),
                      _searchPanel(vm),

                      if (vm.loading) _loadingCard(),

                      if (vm.error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            vm.error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                      if (!vm.loading && vm.result != null) _resultCard(vm),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}