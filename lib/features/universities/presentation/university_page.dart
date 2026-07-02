import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';
import 'university_view_model.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  final controller = TextEditingController(text: 'Dominican Republic');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _openLink(String link) async {
    await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    );
  }

  Widget _universityCard(dynamic university, int index) {
    final link = university.webPages.isNotEmpty ? university.webPages.first : '';
    final domains = university.domains.join(', ');

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 450 + (index * 80)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 26 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(.08),
              Colors.white.withOpacity(.035),
            ],
          ),
          border: Border.all(color: Colors.white.withOpacity(.12)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.electricBlue.withOpacity(.13),
              blurRadius: 26,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'university_$index',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.electricBlue.withOpacity(.18),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: AppTheme.electricBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    university.name,
                    style: const TextStyle(
                      fontSize: 19,
                      height: 1.25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _miniInfo(
              icon: Icons.language_rounded,
              label: 'Dominio',
              value: domains.isEmpty ? 'No disponible' : domains,
            ),

            const SizedBox(height: 10),

            _miniInfo(
              icon: Icons.link_rounded,
              label: 'Sitio web',
              value: link.isEmpty ? 'No disponible' : link,
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: link.isEmpty ? null : () => _openLink(link),
                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                label: const Text(
                  'Visitar',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(.05),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.electricBlue, size: 21),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      color: AppTheme.pearlGray.withOpacity(.62),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchPanel(UniversityViewModel vm) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .92, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          gradient: LinearGradient(
            colors: [
              AppTheme.electricBlue.withOpacity(.26),
              Colors.white.withOpacity(.06),
            ],
          ),
          border: Border.all(color: Colors.white.withOpacity(.16)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.electricBlue.withOpacity(.20),
              blurRadius: 34,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(
              Icons.account_balance_rounded,
              size: 76,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            const Text(
              'Explorador académico',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Busca universidades por país escribiendo el nombre en inglés.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.pearlGray.withOpacity(.76),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => vm.search(controller.text),
              decoration: InputDecoration(
                labelText: 'País en inglés',
                prefixIcon: const Icon(Icons.public_rounded),
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
                onPressed: vm.loading ? null : () => vm.search(controller.text),
                icon: const Icon(Icons.manage_search_rounded),
                label: const Text(
                  'Buscar universidades',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(.06),
        border: Border.all(color: Colors.white.withOpacity(.12)),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          const Text(
            'Buscando universidades...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Conectando con el listado académico internacional.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.pearlGray.withOpacity(.72),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UniversityViewModel>();

    return Scaffold(
      body: PremiumPageBackground(
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
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
                      'Universidades',
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

              const SizedBox(height: 24),

              _searchPanel(vm),

              if (vm.loading) _loading(),

              if (vm.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    vm.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),

              if (!vm.loading && vm.universities.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  '${vm.universities.length} universidades encontradas',
                  style: TextStyle(
                    color: AppTheme.pearlGray.withOpacity(.72),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ...vm.universities.asMap().entries.map(
                      (entry) => _universityCard(entry.value, entry.key),
                    ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}