class Dhikr {
  final String text;
  final int count;
  final String? description;
  final bool isFavorite;

  Dhikr({
    required this.text,
    required this.count,
    this.description,
    this.isFavorite = false,
  });

  Dhikr copyWith({
    String? text,
    int? count,
    String? description,
    bool? isFavorite,
  }) {
    return Dhikr(
      text: text ?? this.text,
      count: count ?? this.count,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'count': count,
      'description': description,
      'isFavorite': isFavorite,
    };
  }

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      text: json['text'],
      count: json['count'],
      description: json['description'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
