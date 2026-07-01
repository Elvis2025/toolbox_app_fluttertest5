import 'package:flutter/material.dart';

import '../../../about/presentation/pages/about_page.dart';
import '../../../age/presentation/age_page.dart';
import '../../../gender/presentation/gender_page.dart';
import '../../../news/presentation/news_page.dart';
import '../../../pokemon/presentation/pokemon_page.dart';
import '../../../universities/presentation/university_page.dart';
import '../../../weather/presentation/weather_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem('Predecir género', Icons.wc, const GenderPage()),
      _MenuItem('Determinar edad', Icons.cake, const AgePage()),
      _MenuItem('Universidades', Icons.school, const UniversityPage()),
      _MenuItem('Clima RD', Icons.cloud, const WeatherPage()),
      _MenuItem('Pokémon', Icons.catching_pokemon, const PokemonPage()),
      _MenuItem('Noticias WordPress', Icons.article, const NewsPage()),
      _MenuItem('Acerca de', Icons.person, const AboutPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Caja de Herramientas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
              ),
            ),
            child: const Column(
              children: [
                Icon(Icons.home_repair_service, size: 110, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'Una app para varias herramientas útiles',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...items.map((item) => Card(
                child: ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
                ),
              )),
        ],
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Widget page;
  _MenuItem(this.title, this.icon, this.page);
}
