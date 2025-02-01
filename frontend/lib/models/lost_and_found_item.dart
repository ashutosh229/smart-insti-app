// This class is used to create an object of Lost and Found item

class LostAndFoundItem {
  String? id;
  String name;
  String lastSeenLocation;
  String? imagePath;
  String description;
  String contactNumber;
  String listerId;
  bool isLost;

  LostAndFoundItem({
    this.id,
    required this.name,
    required this.lastSeenLocation,
    this.imagePath,
    required this.description,
    required this.contactNumber,
    required this.listerId,
    required this.isLost,
  });

  factory LostAndFoundItem.fromJson(Map<String, dynamic> json) {
    return LostAndFoundItem(
      id: json['_id'],
      name: json['name'],
      lastSeenLocation: json['lastSeenLocation'],
      imagePath: json['imagePath'],
      description: json['description'],
      contactNumber: json['contactNumber'],
      listerId: json['listerId'],
      isLost: json['isLost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastSeenLocation': lastSeenLocation,
      'imagePath': imagePath,
      'description': description,
      'contact': contactNumber,
      'listerId': listerId,
      'isLost': isLost,
    };
  }
}
