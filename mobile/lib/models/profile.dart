// To parse this JSON data, do
//
//     final ProfileModel = ProfileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel ProfileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String ProfileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.image,
    required this.name,
    required this.scootername,
    required this.email,
    required this.username,
  });

  String username;
  String name;
  String email;
  String? image;
  String? scootername;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        username: json["username"],
        name: json["name"],
        email: json["email"],
        image: json["image"] as String?,
        scootername: json["scootername"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "image": image,
        "scootername": scootername,
      };
}
