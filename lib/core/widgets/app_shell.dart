import 'package:flutter/material.dart';
import 'package:toolbox_app/features/news/presentation/news_page.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/gender/presentation/gender_page.dart';
import '../../features/age/presentation/age_page.dart';
import '../../features/weather/presentation/weather_page.dart';
import '../../features/pokemon/presentation/pokemon_page.dart';
import '../../features/about/presentation/pages/about_page.dart';
import '../../features/universities/presentation/university_page.dart';

import '../navigation/animated_route.dart';
import 'magic_toolbox_drawer.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void goToPage(Widget page) {
    Navigator.pop(context);

    Future.delayed(const Duration(milliseconds: 180), () {
      Navigator.push(
        context,
        AnimatedRoute.slideFade(page),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MagicToolboxDrawer(
        onHome: () => Navigator.pop(context),
        onGender: () => goToPage(const GenderPage()),
        onAge: () => goToPage(const AgePage()),
        onUniversities: () => goToPage(const UniversityPage()),
        onWeather: () => goToPage(const WeatherPage()),
        onPokemon: () => goToPage(const PokemonPage()),
        onWordpress: () => goToPage(const NewsPage()),
        onAbout: () => goToPage(const AboutPage()),
      ),
      body: const HomePage(),
    );
  }
}