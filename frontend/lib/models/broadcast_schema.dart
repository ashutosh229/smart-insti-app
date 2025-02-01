class Broadcast {
  final String title;
  final String body;
  final DateTime date;

  Broadcast({
    required this.title,
    required this.body,
    required this.date,
  });

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    return Broadcast(
      title: json['title'],
      body: json['body'],
      date: DateTime.parse(json['date']), // Update parsing to 'date'
    );
  }
}
