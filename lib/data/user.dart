// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.username,
    required this.phone,
    required this.cite,
    required this.weddingDate,
  });

  String username;
  String phone;
  String cite;
  String weddingDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        phone: json["phone"],
        cite: json["cite"],
        weddingDate: json["wedding_date"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
        "cite": cite,
        "wedding_date": weddingDate,
      };



}
