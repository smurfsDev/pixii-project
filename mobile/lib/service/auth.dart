import 'dart:convert';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;
import 'package:mobile/models/Role.dart';

class AuthService with ChangeNotifier {
  late User? user = null;
  late String error;
  late String registerError;
  late String verifyError;
  late bool _loggedIn = false;

  AuthService() {
    loadSettings();
  }

  final _storage = const FlutterSecureStorage();

  bool get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }


  Future _saveToStorage(String key, String token) async {
    var writeToken = await _storage.write(key: key, value: token);
    // var readToken = await _storage.read(key: 'token');
    //print(readToken);

    return writeToken;
  }

  Future<String?> _getFromStorage(String key) async {
    var writeToken = await _storage.read(key: key);
    // var readToken = await _storage.read(key: 'token');
    //print(readToken);

    return writeToken;
  }


  Future loadSettings() async {
    var token = await _getFromStorage('token');
    var user = await _getFromStorage('user');
    var loggedIn = await _storage.read(key: 'loggedIn');
    if (token != null && user != null && loggedIn != null) {
      this.user = User.fromJson(jsonDecode(user));
      this._loggedIn = loggedIn == "false" ? false : true;
      notifyListeners();
    }
  }

  Future login(String username, String password) async {
    loggedIn = true;

    final request = {'username': username, 'password': password};
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/authenticate'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      loggedIn = false;

      if (response.statusCode == 200) {
        final data = loginResponseFromJson(response.body);
        user = data.user;
        var isScooterOwner = false;
        data.user.role.forEach((element) {
          if (element['name'] == "Scooter Owner") {
            isScooterOwner = true;
          }
        });
        if (!isScooterOwner) {
          error = "You are not a scooter owner";
          return false;
        }
        _loggedIn = true;
        await _saveToStorage('token', data.token);
        await _saveToStorage('user', jsonEncode(user?.toJson()));
        await _saveToStorage('loggedIn', jsonEncode(_loggedIn));
        return true;
        notifyListeners();
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
  Future<bool> register( String username, String password, String email, String name,String scooterId , String confirmPassword) async {
    final request = {'username': username, 'password': password, 'email': email, 'name': name , 'role': "Scooter Owner" , 'confirmPassword': confirmPassword, "scooterId": scooterId};
    print(request);
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/register'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        return true;
      } else {
        registerError = JsonDecoder().convert(response.body)['message'];
        return false;
      }
    } catch (e) {
      error = e.toString();
      registerError = error;
      return false;
    }
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

  Future<bool> verifyEmail(String email,String token) async {
    final request = {'email': email,'code': token};
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/verify'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      } else {
        verifyError = JsonDecoder().convert(response.body)['message'];
        return false;
      }
    } catch (e) {
      verifyError = e.toString();
      return false;
    }
  }

  Future resendVerificationToken(String email) async {
    final request = {'email': email};
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/resend'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      } else {
        verifyError = JsonDecoder().convert(response.body)['message'];
        return false;
      }
    } catch (e) {
      verifyError = e.toString();
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
  //fetch roles
  Future<List<Role>> getRoles() async {
    final response = await http.get(
        Uri.parse('${Environment.apiUrl}/roles'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Role> roles = [];
      for (var item in data['roles']) {
        roles.add(Role.fromJson(item));
      }
      return roles;
    } else {
      print("error");
      return [];
    }
  }
  Future<bool> ForgotPassword(String email) async {
    final request = {'email': email};
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/forgot_password'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      } else {
        verifyError = JsonDecoder().convert(response.body)['message'];
        return false;
      }
    } catch (e) {
      verifyError = e.toString();
      return false;
    }
  }
  Future<bool> ResetPassword(String email,String token,String password) async {
    final request = {'email': email,'token': token,'password': password};
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/reset_password'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return true;
      } else {
        verifyError = JsonDecoder().convert(response.body)['message'];
        return false;
      }
    } catch (e) {
      verifyError = e.toString();
      return false;
    }
  }
}
