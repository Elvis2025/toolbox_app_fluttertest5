import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/my_photo.png'),
            child: Icon(Icons.person, size: 80),
          ),
          SizedBox(height: 20),
          Text('Elvis Jesús Hernández Suárez', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Desarrollador de Software', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ListTile(leading: Icon(Icons.email), title: Text('correo@ejemplo.com')),
          ListTile(leading: Icon(Icons.phone), title: Text('+1 809 000 0000')),
          ListTile(leading: Icon(Icons.link), title: Text('GitHub / LinkedIn / Portafolio')),
          SizedBox(height: 16),
          Text('Aplicación académica desarrollada en Flutter con arquitectura MVVM y consumo de APIs externas.'),
        ],
      ),
    );
  }
}
