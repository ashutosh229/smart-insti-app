class Room {
  Room({this.occupantId, this.id, required this.name, this.vacant = true, this.occupantName});

  final String? id;
  final String name;
  final bool vacant;
  final String? occupantId;
  final String? occupantName;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'],
      name: json['name'],
      vacant: json['vacant'],
      occupantId: json['occupantId'],
      occupantName: json['occupantName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'vacant': vacant,
      'occupantId': occupantId,
      'occupantName': occupantName,
    };
  }
}
