import 'dart:convert';

Status statusFromJson(String str) => Status.fromJson(json.decode(str));
String statusToJson(Status data) => json.encode(data.toJson());

class Status {
  final String? id;
  final String? name;

  // final String? color;
  const Status({required this.id, required this.name});
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['_id'] as String,
      name: json['name'] as String?,
      // color: json['color'] as String?,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      // 'color': color,
    };
  }

  @override
  String toString() {
    return 'Status{id: $id, name: $name}';
  }
}
