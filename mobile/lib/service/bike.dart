import 'dart:convert';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;
import 'package:mobile/models/BikeData.dart';
import 'package:mobile/utils/storage.dart';

class BikeService with ChangeNotifier {
  late BikeData? bikeData = null;
  late String error;

  final _storage = const FlutterSecureStorage();

  Future _saveToStorage(String key, String token) async {
    var writeToken = await _storage.write(key: key, value: token);
    return writeToken;
  }

  Future<String?> _getFromStorage(String key) async {
    var writeToken = await _storage.read(key: key);
    return writeToken;
  }

  Future loadSettings() async {
    var bikeData = await _getFromStorage('bikeData');
    if (bikeData != null) {
      this.bikeData = BikeData.fromJson(jsonDecode(bikeData));
      notifyListeners();
    }
  }

  Future getBikeData() async {
    try {
      final authService = AuthService();
      await authService.loadSettings();
      // get bike id from roles in user where role.name == 'Scooter Owner'
      var bikeId = authService.user!.role
          .where((element) => element['name'] == 'Scooter Owner')
          .toList()[0]['bike_id'];

      print(bikeId);

      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/node/bike/$bikeId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        this.bikeData = BikeData.fromJson(jsonDecode(response.body));
        _saveToStorage('bikeData', response.body);
        notifyListeners();
      } else {
        error = jsonDecode(response.body)['message'];
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  BikeService() {
    loadSettings();
  }

  Future LockBike(bool state) async {
    try {
      final authService = AuthService();
      await authService.loadSettings();
      var bikeId = authService.user!.role
          .where((element) => element['name'] == 'Scooter Owner')
          .toList()[0]['bike_id'];

      final response = await http.put(
        Uri.parse('${Environment.apiUrl}/node/bike/lock/$bikeId'),
        body: jsonEncode({'TheftState': state}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'AuthorizationNode': authService.user!.email
        },
      );
      if (response.statusCode == 200) {
        this.bikeData = BikeData.fromJson(jsonDecode(response.body));
        _saveToStorage('bikeData', response.body);
        notifyListeners();
      } else {
        error = jsonDecode(response.body)['message'];
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future ChangeLightState(bool state) async {
    try {
      final authService = AuthService();
      await authService.loadSettings();
      var bikeId = authService.user!.role
          .where((element) => element['name'] == 'Scooter Owner')
          .toList()[0]['bike_id'];

      final response = await http.put(
        Uri.parse('${Environment.apiUrl}/node/bike/light/$bikeId'),
        body: jsonEncode({'LightState': state}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'AuthorizationNode': authService.user!.email
        },
      );
      if (response.statusCode == 200) {
        this.bikeData = BikeData.fromJson(jsonDecode(response.body));
        _saveToStorage('bikeData', response.body);
        notifyListeners();
      } else {
        error = jsonDecode(response.body)['message'];
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future ChangeAlarmState(bool state) async {
    try {
      final authService = AuthService();
      await authService.loadSettings();
      var bikeId = authService.user!.role
          .where((element) => element['name'] == 'Scooter Owner')
          .toList()[0]['bike_id'];

      final response = await http.put(
        Uri.parse('${Environment.apiUrl}/node/bike/alarm/$bikeId'),
        body: jsonEncode({'AlarmState': state}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'AuthorizationNode': authService.user!.email
        },
      );
      if (response.statusCode == 200) {
        this.bikeData = BikeData.fromJson(jsonDecode(response.body));
        _saveToStorage('bikeData', response.body);
        notifyListeners();
      } else {
        error = jsonDecode(response.body)['message'];
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
