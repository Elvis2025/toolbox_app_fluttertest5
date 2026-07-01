import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/network/api_client.dart';
import '../data/pokemon_model.dart';

class PokemonViewModel extends ChangeNotifier {
  PokemonModel? pokemon;
  bool loading = false;
  String? error;
  final AudioPlayer _player = AudioPlayer();

  Future<void> search(String name) async {
    if (name.trim().isEmpty) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiClient.dio.get('https://pokeapi.co/api/v2/pokemon/${name.trim().toLowerCase()}');
      pokemon = PokemonModel.fromJson(response.data);
    } catch (_) {
      error = 'No se encontró el Pokémon.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> playCry() async {
    final url = pokemon?.sound;
    if (url == null || url.isEmpty) return;
    await _player.setUrl(url);
    await _player.play();
  }
}
