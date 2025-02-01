class Achievement {
  final String id;
  final String name;
  final DateTime date;
  final String description;

  Achievement({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['_id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'date': date.toIso8601String(),
      'description': description,
    };
  }
}
