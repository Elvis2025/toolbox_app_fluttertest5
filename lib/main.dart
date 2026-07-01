import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/age/presentation/age_view_model.dart';
import 'features/gender/presentation/gender_view_model.dart';
import 'features/news/presentation/news_view_model.dart';
import 'features/pokemon/presentation/pokemon_view_model.dart';
import 'features/universities/presentation/university_view_model.dart';
import 'features/weather/presentation/weather_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenderViewModel()),
        ChangeNotifierProvider(create: (_) => AgeViewModel()),
        ChangeNotifierProvider(create: (_) => UniversityViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()..loadWeather()),
        ChangeNotifierProvider(create: (_) => PokemonViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()..loadNews()),
      ],
      child: const ToolboxApp(),
    ),
  );
}
