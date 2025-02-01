class MessMenu {
  MessMenu({this.id, required this.kitchenName, this.messMenu});

  String? id;
  String kitchenName;
  Map<String, Map<String, List<String>>>? messMenu;

  factory MessMenu.fromJson(Map<String, dynamic> json) => MessMenu(
        id: json["_id"],
        kitchenName: json["kitchenName"],
        messMenu: Map.from(json["messMenu"]).map((k, v) => MapEntry<String, Map<String, List<String>>>(
            k, Map.from(v).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))))),
      );

  Map<String, dynamic> toJson() => {
        "kitchenName": kitchenName,
        "messMenu": Map.from(messMenu!).map((k, v) => MapEntry<String, dynamic>(
            k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))))),
      };
}
