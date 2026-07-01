import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pokemon_view_model.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});
  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final controller = TextEditingController(text: 'pikachu');
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PokemonViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: controller, decoration: const InputDecoration(labelText: 'Nombre del Pokémon', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          FilledButton(onPressed: () => vm.search(controller.text), child: const Text('Buscar')),
          if (vm.loading) const CircularProgressIndicator(),
          if (vm.error != null) Text(vm.error!, style: const TextStyle(color: Colors.red)),
          if (vm.pokemon != null) Expanded(child: ListView(children: [
            Image.network(vm.pokemon!.image, height: 220),
            Text(vm.pokemon!.name.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Experiencia base: ${vm.pokemon!.baseExperience}', style: const TextStyle(fontSize: 20)),
            Text('Habilidades: ${vm.pokemon!.abilities.join(', ')}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            FilledButton.icon(onPressed: vm.playCry, icon: const Icon(Icons.volume_up), label: const Text('Reproducir sonido')),
          ]))
        ]),
      ),
    );
  }
}
