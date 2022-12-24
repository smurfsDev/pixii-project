import 'dart:convert';

Claim claimFromJson(String str) => Claim.fromJson(json.decode(str));
String claimToJson(Claim data) => json.encode(data.toJson());

class Claim {
  final String? id;
  final String? subject;
  final String? title;
  final String? message;
  final Object? status;
  const Claim({
    required this.id,
    required this.subject,
    required this.title,
    required this.message,
    required this.status,
  });
  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
        id: json['_id'] as String?,
        subject: json['subject'] as String,
        title: json['title'] as String,
        status: json['status'] as Object?,
        message: json['message'] as String);
  }

  Object toJson() {
    return {
      'id': id,
      'subject': subject,
      'title': title,
      'message': message,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'Claim{id: $id, subject: $subject, message: $message, status: $status}';
  }
}
