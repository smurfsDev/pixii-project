// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.username,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  String username;
  String? id;
  String name;
  String email;
  List role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        role: List.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "_id": id,
        "name": name,
        "email": email,
        "roles": List.from(role.map((x) => x)),
      };
}
