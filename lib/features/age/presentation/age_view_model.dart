import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/age_model.dart';

class AgeViewModel extends ChangeNotifier {
  AgeModel? result;
  bool loading = false;
  String? error;

  String get category {
    final age = result?.age ?? 0;
    if (age < 30) return 'Joven';
    if (age < 60) return 'Adulto';
    return 'Anciano';
  }

  IconData get icon {
    if (category == 'Joven') return Icons.child_care;
    if (category == 'Adulto') return Icons.person;
    return Icons.elderly;
  }

  Future<void> predictAge(String name) async {
    if (name.trim().isEmpty) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiClient.dio.get('https://api.agify.io/', queryParameters: {'name': name.trim()});
      result = AgeModel.fromJson(response.data);
    } catch (_) {
      error = 'No se pudo consultar la edad.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
