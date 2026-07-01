import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_view_model.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Clima RD')),
      body: Center(
        child: vm.loading
            ? const CircularProgressIndicator()
            : vm.error != null
                ? Text(vm.error!)
                : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.wb_cloudy, size: 130, color: Colors.blueGrey),
                    Text('${vm.weather?.temperature ?? 0} °C', style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
                    Text(vm.description, style: const TextStyle(fontSize: 24)),
                    Text('Viento: ${vm.weather?.windspeed ?? 0} km/h'),
                    const SizedBox(height: 16),
                    FilledButton(onPressed: vm.loadWeather, child: const Text('Actualizar')),
                  ]),
      ),
    );
  }
}
