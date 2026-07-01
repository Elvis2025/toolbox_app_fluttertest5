import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'university_view_model.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});
  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  final controller = TextEditingController(text: 'Dominican Republic');
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UniversityViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: controller, decoration: const InputDecoration(labelText: 'País en inglés', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          FilledButton(onPressed: () => vm.search(controller.text), child: const Text('Buscar')),
          if (vm.loading) const CircularProgressIndicator(),
          if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
          Expanded(child: ListView.builder(
            itemCount: vm.universities.length,
            itemBuilder: (_, i) {
              final u = vm.universities[i];
              final link = u.webPages.isNotEmpty ? u.webPages.first : '';
              return Card(child: ListTile(
                title: Text(u.name),
                subtitle: Text('Dominio: ${u.domains.join(', ')}\nWeb: $link'),
                onTap: link.isEmpty ? null : () => launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication),
              ));
            },
          ))
        ]),
      ),
    );
  }
}
