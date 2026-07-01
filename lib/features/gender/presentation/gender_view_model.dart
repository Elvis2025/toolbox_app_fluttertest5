import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/gender_model.dart';

class GenderViewModel extends ChangeNotifier {
  GenderModel? result;
  bool loading = false;
  String? error;

  Future<void> predictGender(String name) async {
    if (name.trim().isEmpty) return;
    loading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiClient.dio.get('https://api.genderize.io/', queryParameters: {'name': name.trim()});
      result = GenderModel.fromJson(response.data);
    } catch (e) {
      error = 'No se pudo consultar el género.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
