import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/news_model.dart';

class NewsViewModel extends ChangeNotifier {
  // API WordPress usada para el foro:
  // https://techcrunch.com/wp-json/wp/v2/posts?per_page=3
  final String apiUrl = 'https://techcrunch.com/wp-json/wp/v2/posts?per_page=3';
  final String logoUrl = 'https://techcrunch.com/wp-content/uploads/2018/04/tc-logo-2018-square-reverse2x.png';

  List<NewsModel> news = [];
  bool loading = false;
  String? error;

  Future<void> loadNews() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiClient.dio.get(apiUrl);
      news = (response.data as List).map((e) => NewsModel.fromJson(e)).take(3).toList();
    } catch (_) {
      error = 'No se pudieron cargar las noticias.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
