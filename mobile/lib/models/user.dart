// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {required this.username,
      required this.name,
      required this.email,
      required this.role,
      required this.image,
      required this.scootername});

  String username;
  String name;
  String email;
  List role;
  String? image;
  String? scootername;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        email: json["email"],
        role: List.from(json["roles"].map((x) => x)),
        image: json["image"] as String?,
        scootername: json["scootername"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "roles": List.from(role.map((x) => x)),
        "image": image,
        "scootername": scootername,
      };
}
