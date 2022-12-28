import 'dart:convert';
import 'dart:io';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;

class UserPorfileService with ChangeNotifier {
  late User? user = null;
  late String error;

  final _storage = const FlutterSecureStorage();

  Future<User?> getProfile() async {
    final token = await _storage.read(key: 'token');
    print(token);
    try {
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/profile'),
          headers: {'Content-Type': 'application/json '});
      if (response.statusCode == 200) {
        final data = userFromJson(response.body);
        print(data);
        user = data;
        return user;
      } else {
        error = JsonDecoder().convert(response.body)['error'];
        error = error;
        print(error);
        return user;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      print(error);
      return user;
    }
  }

  Future<bool> updateProfile(String name, String email) async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;
    final request = {'name': name, 'email': email};
    print(request);
    try {
      final response = await http.put(
          Uri.parse('${Environment.apiUrl}/profilemodify'),
          body: jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'AutorizationNode': user!.email
          });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        error = JsonDecoder().convert(response.body)['error'];
        error = error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return false;
    }
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    final request = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    };
    print(request);
    try {
      final response = await http.put(
          Uri.parse('${Environment.apiUrl}/changepassword'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      } else {
        error = JsonDecoder().convert(response.body)['error'];
        error = error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return false;
    }
  }

  Future<bool> addScooterName(String scooterName) async {
    final request = {'scooterName': scooterName};
    print(request);
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/scootername'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        return true;
      } else {
        error = JsonDecoder().convert(response.body)['error'];
        error = error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return false;
    }
  }

  Future<String> getScooterName() async {
    try {
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/gscootername'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = JsonDecoder().convert(response.body)['scooterName'];
        return data;
      } else {
        error = JsonDecoder().convert(response.body)['error'];
        error = error;
        return '';
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return '';
    }
  }

  Future<bool> uploadImage(File image) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('${Environment.apiUrl}/upload'));
    final file = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(file);
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = JsonDecoder().convert(response.body)['error'];
        error = error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return false;
    }
  }

  Future<String> getImage() async {
    try {
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/getimage'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = JsonDecoder().convert(response.body)['image'];
        return data;
      } else {
        error = JsonDecoder().convert(response.body)['error'];
        error = error;
        return '';
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return '';
    }
  }
}
