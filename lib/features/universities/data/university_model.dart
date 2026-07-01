class UniversityModel {
  final String name;
  final List<String> domains;
  final List<String> webPages;
  UniversityModel({required this.name, required this.domains, required this.webPages});
  factory UniversityModel.fromJson(Map<String, dynamic> json) => UniversityModel(
    name: json['name'] ?? '',
    domains: List<String>.from(json['domains'] ?? []),
    webPages: List<String>.from(json['web_pages'] ?? []),
  );
}
