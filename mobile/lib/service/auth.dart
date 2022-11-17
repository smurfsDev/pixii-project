import 'dart:convert';

import 'package:mobile/global/env.dart';
import 'package:mobile/models/login.dart';
import 'package:mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User user;
  late String error;
  bool _loggedIn = false;

  final _storage = const FlutterSecureStorage();

  bool get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

  Future login(String username, String password) async {
    loggedIn = true;

    final request = {'username': username, 'password': password};
    print(Environment.apiUrl);
    print(jsonEncode(request));
    print(request);
    final response = await http.post(
        Uri.parse('${Environment.apiUrl}/authenticate'),
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    loggedIn = false;

    if (response.statusCode == 200) {
      final data = loginResponseFromJson(response.body);
      user = data.user;

      await _saveToStorage('token', data.token);
      await _saveToStorage('user', jsonEncode(user.toJson()));
      return true;
    } else {
      error = JsonDecoder().convert(response.body)['error'];
      error = error;
      return false;
    }
  }

  Future _saveToStorage(String key, String token) async {
    var writeToken = await _storage.write(key: key, value: token);
    // var readToken = await _storage.read(key: 'token');
    //print(readToken);

    return writeToken;
  }

  Future _getFromStorage(String key) async {
    var writeToken = await _storage.read(key: key);
    // var readToken = await _storage.read(key: 'token');
    //print(readToken);

    return writeToken;
  }

  Future<bool> logged() async {
    var token = await _storage.read(key: 'token');

    token ??= "na";

    final response = await http.get(
        Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (response.statusCode == 200) {
      final data = loginResponseFromJson(response.body);
      user = data.user;
      await _saveToStorage('token', data.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }
}
