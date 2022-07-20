// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu({
    required this.id,
    required this.type,
    required this.price,
    required this.image,
    required this.menuItems,
    required this.weddingHallId,
  });

  int id;
  String type;
  int price;
  String image;
  List<int> menuItems;
  int weddingHallId;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        type: json["type"],
        price: json["price"],
        image: json["image"],
        menuItems: List<int>.from(json["menu_items"].map((x) => x)),
        weddingHallId: json["wedding_hall_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "price": price,
        "image": image,
        "menu_items": List<dynamic>.from(menuItems.map((x) => x)),
        "wedding_hall_id": weddingHallId,
      };
}
