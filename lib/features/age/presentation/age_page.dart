import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'age_view_model.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});
  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AgeViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Determinar edad')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: controller, decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          FilledButton(onPressed: () => vm.predictAge(controller.text), child: const Text('Consultar')),
          if (vm.loading) const CircularProgressIndicator(),
          if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
          if (vm.result != null) ...[
            const SizedBox(height: 24),
            Icon(vm.icon, size: 130, color: Theme.of(context).colorScheme.primary),
            Text('${vm.result!.age} años', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text('Estado: ${vm.category}', style: const TextStyle(fontSize: 24)),
          ]
        ]),
      ),
    );
  }
}
