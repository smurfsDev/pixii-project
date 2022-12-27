import 'dart:convert';
import 'dart:ffi';

import 'package:mobile/models/Status.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  String? id;
  String message;
  String user;
  String? claim;
  String? created;

  Comment(
      {required this.id,
      required this.message,
      required this.user,
      required this.claim,
      required this.created});
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] as String?,
      message: json['message'] as String,
      user: json['user'] as String,
      claim: json['claim'] as String,
      created: json['created'] as String?,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'message': message,
      'user': user,
      'claim': claim,
      'created': created,
    };
  }

  @override
  String toString() {
    return 'Comment{id: $id, message: $message, user: $user, claim: $claim, created: $created}';
  }
}
