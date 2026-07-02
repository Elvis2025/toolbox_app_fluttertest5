import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';
import 'gender_view_model.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _resultCard(GenderViewModel vm) {
    final isMale = vm.result?.gender == 'male';

    final Color accent = isMale
        ? const Color(0xFF1E88FF)
        : const Color(0xFFFF4FA3);

    final String genderText = isMale ? 'Masculino' : 'Femenino';
    final IconData icon = isMale ? Icons.male_rounded : Icons.female_rounded;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .85, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: [
              accent.withOpacity(.28),
              Colors.white.withOpacity(.06),
            ],
          ),
          border: Border.all(color: accent.withOpacity(.45)),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(.28),
              blurRadius: 36,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 130, color: accent),
            const SizedBox(height: 14),
            Text(
              vm.result!.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              genderText,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GenderViewModel>();

    return Scaffold(
      body: PremiumPageBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Expanded(
                    child: Text(
                      'Predecir género',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 26),

              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(.06),
                  border: Border.all(color: Colors.white.withOpacity(.12)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.electricBlue.withOpacity(.12),
                      blurRadius: 28,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.wc_rounded,
                      size: 72,
                      color: AppTheme.electricBlue,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Análisis por nombre',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Escribe un nombre y la app estimará si corresponde a género masculino o femenino.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.pearlGray.withOpacity(.72),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        prefixIcon: const Icon(Icons.person_search_rounded),
                        filled: true,
                        fillColor: Colors.white.withOpacity(.07),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton.icon(
                        onPressed: vm.loading
                            ? null
                            : () => vm.predictGender(controller.text),
                        icon: const Icon(Icons.auto_awesome_rounded),
                        label: const Text(
                          'Predecir género',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              if (vm.loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),

              if (vm.error != null)
                Text(
                  vm.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
                ),

              if (vm.result != null) _resultCard(vm),
            ],
          ),
        ),
      ),
    );
  }
}