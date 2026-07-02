import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/premium_page_background.dart';
import 'news_view_model.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Future<void> _openNews(String link) async {
    await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    );
  }

  Widget _animatedNewsCard({
    required BuildContext context,
    required dynamic news,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 120)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 28 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
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
              blurRadius: 28,
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
                  tag: 'news_icon_$index',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.electricBlue.withOpacity(.18),
                    ),
                    child: const Icon(
                      Icons.article_rounded,
                      color: AppTheme.electricBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Noticia ${index + 1}',
                    style: TextStyle(
                      color: AppTheme.pearlGray.withOpacity(.65),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              news.title,
              style: const TextStyle(
                fontSize: 20,
                height: 1.25,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              news.summary,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppTheme.pearlGray.withOpacity(.78),
                height: 1.45,
              ),
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () => _openNews(news.link),
                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                label: const Text(
                  'Visitar noticia',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(NewsViewModel vm) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .88, end: 1),
      duration: const Duration(milliseconds: 750),
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
              AppTheme.electricBlue.withOpacity(.30),
              Colors.white.withOpacity(.06),
            ],
          ),
          border: Border.all(color: Colors.white.withOpacity(.16)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.electricBlue.withOpacity(.22),
              blurRadius: 36,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.network(
                vm.logoUrl,
                height: 90,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.public_rounded,
                    size: 82,
                    color: Colors.white,
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Noticias WordPress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Últimas publicaciones obtenidas en tiempo real desde una API REST de WordPress.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.pearlGray.withOpacity(.75),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewsViewModel>();

    return Scaffold(
      body: PremiumPageBackground(
        child: SafeArea(
          child: vm.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(24),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const Expanded(
                          child: Text(
                            'WordPress Feed',
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

                    _header(vm),

                    const SizedBox(height: 24),

                    if (vm.error != null)
                      Text(
                        vm.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent),
                      ),

                    ...vm.news.toList().asMap().entries.map(
                          (entry) => _animatedNewsCard(
                            context: context,
                            news: entry.value,
                            index: entry.key,
                          ),
                        ),
                  ],
                ),
        ),
      ),
    );
  }
}