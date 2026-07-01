class NewsModel {
  final String title;
  final String summary;
  final String link;
  NewsModel({required this.title, required this.summary, required this.link});

  static String _clean(String html) => html.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&hellip;', '...').replaceAll('&nbsp;', ' ').trim();

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    title: _clean(json['title']?['rendered'] ?? ''),
    summary: _clean(json['excerpt']?['rendered'] ?? ''),
    link: json['link'] ?? '',
  );
}
