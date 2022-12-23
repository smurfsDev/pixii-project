import 'dart:convert';

Claim claimFromJson(String str) => Claim.fromJson(json.decode(str));
String claimToJson(Claim data) => json.encode(data.toJson());

class Claim {
  final int id;
  final String subject;
  final String title;
  final String message;
  const Claim(
      {required this.id,
      required this.subject,
      required this.title,
      required this.message});
  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'] as int,
      subject: json['subject'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
    );
  }

  Object toJson() {
    return {
      'id': id,
      'subject': subject,
      'title': title,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'Claim{id: $id, subject: $subject, message: $message}';
  }
}
