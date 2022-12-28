// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.username,
    required this.name,
    required this.email,
    required this.role,
    // required this.imagePath,
    // required this.scootername
  });

  String username;
  String name;
  String email;
  List role;
  String? imagePath;
  String? scootername;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        email: json["email"],
        role: List.from(json["roles"].map((x) => x)),
        // imagePath: json["imagePath"],
        // scootername: json["scootername"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "roles": List.from(role.map((x) => x)),
        // "imagePath": imagePath,
        // "scootername": scootername,
      };
}
