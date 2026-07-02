import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class SoundService {
  static final AudioPlayer _effectPlayer = AudioPlayer();
  static final AudioPlayer _musicPlayer = AudioPlayer();

  /// true = sonido activado
  static final ValueNotifier<bool> soundEnabled = ValueNotifier(true);

  static bool get enabled => soundEnabled.value;

  /// Activa o desactiva todo el audio
  static Future<void> toggleSound() async {
    soundEnabled.value = !soundEnabled.value;

    if (soundEnabled.value) {
      await playMagicLoop();
    } else {
      await stopMagicLoop();
      await _effectPlayer.stop();
    }
  }

  static Future<void> playMagicLoop() async {
    if (!soundEnabled.value) return;

    try {
      if (_musicPlayer.playing) return;

      await _musicPlayer.setAsset(
        'assets/audio/magic_ambient_soft.wav',
      );

      await _musicPlayer.setLoopMode(LoopMode.one);
      await _musicPlayer.setVolume(0.22);
      await _musicPlayer.play();
    } catch (e) {
      debugPrint('MagicLoop: $e');
    }
  }

  static Future<void> stopMagicLoop() async {
    try {
      await _musicPlayer.stop();
    } catch (_) {}
  }

  static Future<void> playToolEnter() async {
    if (!soundEnabled.value) return;

    try {
      await _effectPlayer.stop();

      await _effectPlayer.setAsset(
        'assets/audio/tool_enter.wav',
      );

      await _effectPlayer.setVolume(1);
      await _effectPlayer.play();

      HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> playSelect(int index) async {
    if (!soundEnabled.value) return;

    final sounds = [
      'assets/audio/select_one.wav',
      'assets/audio/select_two.wav',
      'assets/audio/select_three.wav',
      'assets/audio/select_four.wav',
      'assets/audio/select_five.wav',
      'assets/audio/select_six.wav',
      'assets/audio/select_seven.wav',
    ];

    try {
      await _effectPlayer.stop();

      await _effectPlayer.setAsset(
        sounds[index.clamp(0, sounds.length - 1)],
      );

      await _effectPlayer.setVolume(1);
      await _effectPlayer.play();

      HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}