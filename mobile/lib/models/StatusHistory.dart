import 'dart:convert';
import 'dart:ffi';

import 'package:mobile/models/Status.dart';

StatusHistory claimFromJson(String str) =>
    StatusHistory.fromJson(json.decode(str));
String statusHistoryToJson(StatusHistory data) => json.encode(data.toJson());

class StatusHistory {
  String? id;
  String old_status;
  String new_status;
  String? date;
  String? author;

  StatusHistory(
      {required this.id,
      required this.old_status,
      required this.new_status,
      required this.date,
      required this.author});
  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      id: json['_id'] as String?,
      old_status: json['old_status'] as String,
      new_status: json['new_status'] as String,
      date: json['date'] as String,
      author: json['author'] as String?,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'old_status': old_status,
      'new_status': new_status,
      'date': date,
      'author': author,
    };
  }

  @override
  String toString() {
    return 'StatusHistory{id: $id, old_status: $old_status, new_status: $new_status, author: $author, date: $date}';
  }
}
