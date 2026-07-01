import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherModel? weather;
  bool loading = false;
  String? error;

  String get description {
    final code = weather?.weathercode ?? 0;
    if (code == 0) return 'Cielo despejado';
    if ([1, 2, 3].contains(code)) return 'Parcialmente nublado';
    if ([45, 48].contains(code)) return 'Niebla';
    if ([51, 53, 55, 61, 63, 65, 80, 81, 82].contains(code)) return 'Lluvia';
    if ([95, 96, 99].contains(code)) return 'Tormenta';
    return 'Clima variable';
  }

  Future<void> loadWeather() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiClient.dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': 18.4861,
          'longitude': -69.9312,
          'current_weather': true,
          'timezone': 'America/Santo_Domingo',
        },
      );
      weather = WeatherModel.fromJson(response.data);
    } catch (_) {
      error = 'No se pudo cargar el clima.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
