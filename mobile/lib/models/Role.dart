import 'dart:convert';
  Role roleFromJson(String str) => Role.fromJson(json.decode(str));
  String roleToJson(Role data) => json.encode(data.toJson());
class Role{
  final int id;
  final String name; 
  const Role({required this.id,required this.name});
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
  
  Object toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  @override
  String toString() {
    return 'Role{id: $id, name: $name}';
  }
}