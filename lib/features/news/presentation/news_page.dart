import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_view_model.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewsViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias WordPress')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(children: [
                Image.network(vm.logoUrl, height: 100),
                const SizedBox(height: 12),
                Text('API: ${vm.apiUrl}', style: const TextStyle(fontSize: 12)),
                if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
                ...vm.news.map((n) => Card(child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(n.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(n.summary),
                    TextButton(onPressed: () => launchUrl(Uri.parse(n.link), mode: LaunchMode.externalApplication), child: const Text('Visitar')),
                  ]),
                )))
              ]),
            ),
    );
  }
}
