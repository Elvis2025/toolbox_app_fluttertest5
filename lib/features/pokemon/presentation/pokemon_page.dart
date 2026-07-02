import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';
import 'pokemon_view_model.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage>
    with TickerProviderStateMixin {
  final controller = TextEditingController(text: 'pikachu');

  late final AnimationController _fallController;
  late final AnimationController _glowController;
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    _fallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _fallController.dispose();
    _glowController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _search(PokemonViewModel vm) async {
    _fallController.reset();
    await vm.search(controller.text);
    if (mounted && vm.pokemon != null) {
      _fallController.forward();
    }
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
            '⚡ Pokémon ⚡',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }

  Widget _searchBox(PokemonViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(.06),
        border: Border.all(color: Colors.white.withOpacity(.12)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.electricBlue.withOpacity(.16),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _search(vm),
            decoration: InputDecoration(
              labelText: 'Nombre del Pokémon',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: Colors.white.withOpacity(.07),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: vm.loading ? null : () => _search(vm),
              icon: const Icon(Icons.auto_awesome_rounded),
              label: const Text(
                'Buscar Pokémon',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingPokemon() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, _) {
        final value = _glowController.value;

        return Container(
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: LinearGradient(
              begin: Alignment(-1 + value * 2, -1),
              end: Alignment(1 - value * 2, 1),
              colors: [
                const Color(0xFF102A55),
                const Color(0xFF1E88FF).withOpacity(.55),
                const Color(0xFFFF4FD8).withOpacity(.45),
                const Color(0xFF102A55),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(.16)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.electricBlue.withOpacity(.35),
                blurRadius: 40,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            children: [
              Transform.rotate(
                angle: value * math.pi * 2,
                child: const Icon(
                  Icons.catching_pokemon_rounded,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Buscando Pokémon!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Luces, energía y datos viajando desde la PokéAPI...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.pearlGray.withOpacity(.78),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  minHeight: 9,
                  backgroundColor: Colors.white.withOpacity(.12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _fallingPokemonImage(String image) {
    return AnimatedBuilder(
      animation: Listenable.merge([_fallController, _floatController]),
      builder: (context, child) {
        final fall = Curves.easeOutBack.transform(_fallController.value);
        final floating = math.sin(_floatController.value * math.pi * 2) * 8;

        return Transform.translate(
          offset: Offset(0, -260 + (260 * fall) + floating),
          child: Transform.rotate(
            angle: math.sin(_floatController.value * math.pi * 2) * .05,
            child: child,
          ),
        );
      },
      child: Image.network(
        image,
        height: 230,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _pokemonResult(PokemonViewModel vm) {
    final pokemon = vm.pokemon!;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: LinearGradient(
          colors: [
            AppTheme.electricBlue.withOpacity(.24),
            Colors.white.withOpacity(.06),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(.16)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.electricBlue.withOpacity(.24),
            blurRadius: 38,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, _) {
                    return Transform.rotate(
                      angle: _glowController.value * math.pi * 2,
                      child: Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Colors.transparent,
                              AppTheme.electricBlue.withOpacity(.35),
                              Colors.purpleAccent.withOpacity(.28),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                _fallingPokemonImage(pokemon.image),
              ],
            ),
          ),

          Text(
            pokemon.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),

          const SizedBox(height: 18),

          _infoTile(
            icon: Icons.stars_rounded,
            title: 'Experiencia base',
            value: pokemon.baseExperience.toString(),
          ),

          _infoTile(
            icon: Icons.flash_on_rounded,
            title: 'Habilidades',
            value: pokemon.abilities.join(', '),
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 56,
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: vm.playCry,
              icon: const Icon(Icons.volume_up_rounded),
              label: const Text(
                'Reproducir sonido',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.pearlGray.withOpacity(.62),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PokemonViewModel>();

    return Scaffold(
      body: PremiumPageBackground(
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            children: [
              _header(),
              const SizedBox(height: 24),
              _searchBox(vm),
              if (vm.loading) _loadingPokemon(),
              if (vm.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    vm.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              if (!vm.loading && vm.pokemon != null) _pokemonResult(vm),
            ],
          ),
        ),
      ),
    );
  }
}