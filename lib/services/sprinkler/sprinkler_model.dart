class Sprinkler {
  bool isActive;

  Sprinkler({required this.isActive});

  factory Sprinkler.fromJson(Map<String, dynamic> json) {
    return Sprinkler(isActive: json['data']['is_active']);
  }
}
