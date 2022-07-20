// To parse this JSON data, do
//
//     final menuItem = menuItemFromJson(jsonString);

import 'dart:convert';

MenuItem menuItemFromJson(String str) => MenuItem.fromJson(json.decode(str));

String menuItemToJson(MenuItem data) => json.encode(data.toJson());

class MenuItem {
    MenuItem({
        required this.name,
        required this.menuId,
    });

    String name;
    int menuId;

    factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        name: json["name"],
        menuId: json["menu_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "menu_id": menuId,
    };
}
