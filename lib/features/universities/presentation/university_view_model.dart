import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/university_model.dart';

class UniversityViewModel extends ChangeNotifier {
  List<UniversityModel> universities = [];
  bool loading = false;
  String? error;

  Future<void> search(String country) async {
    if (country.trim().isEmpty) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      final encoded = country.trim().replaceAll(' ', '+');
      final response = await ApiClient.dio.get('https://adamix.net/proxy.php?country=$encoded');
      universities = (response.data as List).map((e) => UniversityModel.fromJson(e)).toList();
    } catch (_) {
      error = 'No se pudieron cargar las universidades.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
