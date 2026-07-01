class WeatherModel {
  final double temperature;
  final double windspeed;
  final int weathercode;
  WeatherModel({required this.temperature, required this.windspeed, required this.weathercode});
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];
    return WeatherModel(
      temperature: (current['temperature'] ?? 0).toDouble(),
      windspeed: (current['windspeed'] ?? 0).toDouble(),
      weathercode: current['weathercode'] ?? 0,
    );
  }
}
