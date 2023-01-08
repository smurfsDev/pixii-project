import 'dart:convert';
import 'dart:io';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

class UserPorfileService with ChangeNotifier {
  late User user = User(
      username: '', name: '', email: '', role: [], image: '', scootername: '');
  late String error;

  final _storage = const FlutterSecureStorage();

  Future getProfile() async {
    var userService = AuthService();
    userService.loadSettings();
    var token = await _storage.read(key: "token");
    try {
      final response = await http
          .get(Uri.parse('${Environment.apiUrl}/getprofile'), headers: {
        'Content-Type': 'application/json ',
        'Authorization': "Bearer ${token!}"
      });
      getImage();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _storage.write(key: 'userprofile', value: (response.body));
        notifyListeners();
        return data;
      } else {
        error = const JsonDecoder().convert(response.body)['error'];
        error = error;

        return user;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return user;
    }
  }

  Future getscootername() async {
    var userService = AuthService();
    userService.loadSettings();
    var token = await _storage.read(key: "token");

    try {
      final response = await http
          .get(Uri.parse('${Environment.apiUrl}/gscootername'), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token!}"
      });
      if (response.statusCode == 200) {
        final data = userFromJson(response.body);
        user = data;
        notifyListeners();
        return user.scootername;
      } else {
        error = const JsonDecoder().convert(response.body)['error'];
        error = error;
        return '';
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return '';
    }
  }

  Future<bool> updateProfile(String name, String email) async {
    final request = {'name': name, 'email': email};
    var userService = AuthService();
    userService.loadSettings();
    var token = await _storage.read(key: "token");

    try {
      final response = await http.put(
          Uri.parse('${Environment.apiUrl}/profilemodify'),
          body: jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${token!}"
          });
      getProfile();
      if (response.statusCode == 200) {
        return true;
      } else {
        error = const JsonDecoder().convert(response.body)['error'];
        error = error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return false;
    }
  }

  Future changePassword(
      String oldPassword, String Password, String confirmPassword) async {
    var userService = AuthService();
    userService.loadSettings();
    var token = await _storage.read(key: "token");

    final request = {
      'oldpassword': oldPassword,
      'password': Password,
      'confirmpassword': confirmPassword
    };
    final response = await http.put(
        Uri.parse('${Environment.apiUrl}/changepassword'),
        body: jsonEncode(request),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${token!}"
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future updatescootername(String scootername) async {
    final request = <String, String>{'scootername': scootername};
    var userService = AuthService();
    userService.loadSettings();
    var token = await _storage.read(key: "token");

    try {
      final response = await http.put(
        Uri.parse('${Environment.apiUrl}/scootername'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer ${token!}"
        },
        body: jsonEncode(request),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        error = const JsonDecoder().convert(response.body)['error'];
        error = error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return false;
    }
  }

  Future getImage() async {
    final token = await _storage.read(key: 'token');
    try {
      final response =
          await http.get(Uri.parse('${Environment.apiUrl}/getimage'), headers: {
        'Content-Type': 'application/json',
        "authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        final data = const JsonDecoder().convert(response.body)['image'];
        return data;
      } else {
        error = const JsonDecoder().convert(response.body)['error'];
        error = error;
        return '';
      }
    } catch (e) {
      error = e.toString();
      error = error;
      return '';
    }
  }

  Future updateProfileImage(File permImage) async {
    try {
      var length = await permImage.length();
      var stream =
          http.ByteStream(DelegatingStream.typed(permImage.openRead()));
      var uri = Uri.parse("${Environment.apiUrl}/upload");
      var request = http.MultipartRequest("POST", uri);
      const storage = FlutterSecureStorage();
      var userService = AuthService();
      userService.loadSettings();
      var token = await storage.read(key: "token");

      request.headers.addAll({
        "authorization": "Bearer $token",
      });

      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(permImage.path));
      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      print(json.decode(response.stream.toString()));
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      getProfile();
    } catch (e) {
      print(e);
    }
  }
}
