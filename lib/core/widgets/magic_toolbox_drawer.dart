import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MagicToolboxDrawer extends StatefulWidget {
  final VoidCallback onHome;
  final VoidCallback onGender;
  final VoidCallback onAge;
  final VoidCallback onUniversities;
  final VoidCallback onWeather;
  final VoidCallback onPokemon;
  final VoidCallback onWordpress;
  final VoidCallback onAbout;

  const MagicToolboxDrawer({
    super.key,
    required this.onHome,
    required this.onGender,
    required this.onAge,
    required this.onUniversities,
    required this.onWeather,
    required this.onPokemon,
    required this.onWordpress,
    required this.onAbout,
  });

  @override
  State<MagicToolboxDrawer> createState() => _MagicToolboxDrawerState();
}

class _MagicToolboxDrawerState extends State<MagicToolboxDrawer>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fade;
  late final Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    fade = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );

    slide = Tween<Offset>(
      begin: const Offset(-0.18, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white.withOpacity(.06),
              border: Border.all(
                color: Colors.white.withOpacity(.10),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.electricBlue.withOpacity(.18),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.electricBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.pearlGray.withOpacity(.65),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.navy,
      width: MediaQuery.of(context).size.width * .86,
      child: Stack(
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
            top: 80,
            right: -45,
            child: Icon(
              Icons.construction_rounded,
              size: 190,
              color: Colors.white.withOpacity(.04),
            ),
          ),

          Positioned(
            bottom: 70,
            left: -30,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 160,
              color: Colors.white.withOpacity(.035),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.electricBlue.withOpacity(.35),
                          Colors.white.withOpacity(.06),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(.16),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.home_repair_service_rounded,
                          size: 58,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Magic Toolbox',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Caja mágica de herramientas',
                          style: TextStyle(
                            color: AppTheme.pearlGray.withOpacity(.75),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  Expanded(
                    child: ListView(
                      children: [
                        menuItem(
                          icon: Icons.dashboard_rounded,
                          title: 'Inicio',
                          subtitle: 'Panel principal',
                          onTap: widget.onHome,
                        ),
                        menuItem(
                          icon: Icons.wc_rounded,
                          title: 'Género',
                          subtitle: 'Predicción por nombre',
                          onTap: widget.onGender,
                        ),
                        menuItem(
                          icon: Icons.cake_rounded,
                          title: 'Edad',
                          subtitle: 'Joven, adulto o anciano',
                          onTap: widget.onAge,
                        ),
                        menuItem(
                          icon: Icons.school_rounded,
                          title: 'Universidades',
                          subtitle: 'Instituciones por país',
                          onTap: widget.onUniversities,
                        ),
                        menuItem(
                          icon: Icons.cloud_rounded,
                          title: 'Clima RD',
                          subtitle: 'Estado del clima actual',
                          onTap: widget.onWeather,
                        ),
                        menuItem(
                          icon: Icons.catching_pokemon_rounded,
                          title: 'Pokémon',
                          subtitle: 'Foto, habilidades y sonido',
                          onTap: widget.onPokemon,
                        ),
                        menuItem(
                          icon: Icons.article_rounded,
                          title: 'WordPress News',
                          subtitle: 'Últimas noticias',
                          onTap: widget.onWordpress,
                        ),
                        menuItem(
                          icon: Icons.person_rounded,
                          title: 'Acerca de',
                          subtitle: 'Contacto profesional',
                          onTap: widget.onAbout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}