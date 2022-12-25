import 'dart:convert';
import 'dart:ffi';

import 'package:mobile/models/Status.dart';

Claim claimFromJson(String str) => Claim.fromJson(json.decode(str));
String claimToJson(Claim data) => json.encode(data.toJson());

class Claim {
  final String? id;
  final String? subject;
  final String? title;
  final String? message;
  final Map<String, dynamic> status;
  final String? created;
  final List<dynamic> technicians;

  const Claim(
      {required this.id,
      required this.subject,
      required this.title,
      required this.message,
      required this.status,
      required this.technicians,
      required this.created});
  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
        id: json['_id'] as String?,
        subject: json['subject'] as String,
        title: json['title'] as String,
        status: json['status'] as Map<String, dynamic>,
        created: json['created'] as String?,
        technicians: json['_technician'] as List<dynamic>,
        message: json['message'] as String);
  }

  Map toJson() {
    //Map? status = this.status != null ? this.status!.toJson() : null;

    return {
      'id': id,
      'subject': subject,
      'title': title,
      'message': message,
      'status': status,
      'created': created,
      'technicians': technicians,
    };
  }

  // Object toJson() {
  //   return {
  //     'id': id,
  //     'subject': subject,
  //     'title': title,
  //     'message': message,
  //     'status': status,
  //     'created': created,
  //   };
  // }

  @override
  String toString() {
    return 'Claim{id: $id, subject: $subject, message: $message, status: $status, created: $created,technicians: $technicians}';
  }
}
