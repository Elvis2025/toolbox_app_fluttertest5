import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/app_shell.dart';

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
        ChangeNotifierProvider(create: (_) => AgeViewModel()),
        ChangeNotifierProvider(create: (_) => GenderViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => PokemonViewModel()),
        ChangeNotifierProvider(create: (_) => UniversityViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: const ToolboxApp(),
    ),
  );
}

class ToolboxApp extends StatelessWidget {
  const ToolboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Toolbox',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}