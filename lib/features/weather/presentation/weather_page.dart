import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';
import 'weather_view_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _weatherAnimation;

  @override
  void initState() {
    super.initState();

    _weatherAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _weatherAnimation.dispose();
    super.dispose();
  }

  Widget _header() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        const Expanded(
          child: Text(
            'Clima RD',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }

  Widget _loadingCard() {
    return Container(
      margin: const EdgeInsets.only(top: 28),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [
            AppTheme.electricBlue.withOpacity(.24),
            Colors.white.withOpacity(.06),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(.14)),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 18),
          const Text(
            'Consultando el clima...',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Obteniendo información actual de República Dominicana.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.pearlGray.withOpacity(.72),
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherHero(WeatherViewModel vm) {
    final temp = vm.weather?.temperature ?? 0;
    final wind = vm.weather?.windspeed ?? 0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .88, end: 1),
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1E88FF).withOpacity(.36),
              const Color(0xFF102A55).withOpacity(.65),
              Colors.white.withOpacity(.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(.16)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.electricBlue.withOpacity(.25),
              blurRadius: 40,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _weatherAnimation,
              builder: (context, child) {
                final move = math.sin(_weatherAnimation.value * math.pi) * 12;

                return Transform.translate(
                  offset: Offset(0, -move),
                  child: child,
                );
              },
              child: const Icon(
                Icons.wb_cloudy_rounded,
                size: 135,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '$temp °C',
              style: const TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              vm.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: AppTheme.pearlGray.withOpacity(.85),
              ),
            ),

            const SizedBox(height: 24),

            _infoTile(
              icon: Icons.air_rounded,
              title: 'Viento',
              value: '$wind km/h',
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: vm.loading ? null : vm.loadWeather,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text(
                  'Actualizar clima',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(.06),
        border: Border.all(color: Colors.white.withOpacity(.10)),
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
          Text(
            title,
            style: TextStyle(
              color: AppTheme.pearlGray.withOpacity(.62),
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white.withOpacity(.055),
        border: Border.all(color: Colors.white.withOpacity(.11)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_rounded,
            color: AppTheme.electricBlue,
            size: 34,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Clima actual para República Dominicana, consultado en tiempo real.',
              style: TextStyle(
                color: AppTheme.pearlGray.withOpacity(.78),
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();

    return Scaffold(
      body: PremiumPageBackground(
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            children: [
              _header(),
              const SizedBox(height: 24),
              _introCard(),
              if (vm.loading) _loadingCard(),
              if (vm.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    vm.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              if (!vm.loading && vm.error == null) ...[
                const SizedBox(height: 24),
                _weatherHero(vm),
              ],
            ],
          ),
        ),
      ),
    );
  }
}