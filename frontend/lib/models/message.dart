class Message {
  final String? id;
  final String sender;
  final String content;
  final DateTime? timestamp;

  Message({
    this.id,
    required this.sender,
    required this.content,
    this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      sender: json['sender'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'content': content,
      'timestamp': timestamp!.toIso8601String(),
    };
  }
}
