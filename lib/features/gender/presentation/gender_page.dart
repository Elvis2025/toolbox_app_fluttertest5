import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gender_view_model.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GenderViewModel>();
    final isMale = vm.result?.gender == 'male';
    final bg = vm.result == null ? Colors.white : isMale ? Colors.blue.shade100 : Colors.pink.shade100;

    return Scaffold(
      appBar: AppBar(title: const Text('Predecir género')),
      backgroundColor: bg,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: controller, decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            FilledButton(onPressed: () => vm.predictGender(controller.text), child: const Text('Predecir')),
            if (vm.loading) const CircularProgressIndicator(),
            if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
            if (vm.result != null) ...[
              const SizedBox(height: 24),
              Icon(isMale ? Icons.male : Icons.female, size: 120, color: isMale ? Colors.blue : Colors.pink),
              Text('Nombre: ${vm.result!.name}', style: const TextStyle(fontSize: 22)),
              Text('Género: ${isMale ? 'Masculino' : 'Femenino'}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }
}
