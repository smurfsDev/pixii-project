import 'dart:convert';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/models/StatusHistory.dart';

class ClaimsService with ChangeNotifier {
  late Claim? claim = null;
  late String error;
  late String createClaimError;

  Future<bool> createClaim(String subject, String title, String message) async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;
    if (user == null) {
      createClaimError = "unauthorized";
      return false;
    }
    final request = {
      'subject': subject,
      'title': title,
      'message': message,
      'user': user
    };
    // print("request $request");
    try {
      final response = await http.post(
          Uri.parse('http://192.168.137.1:8080/node/claims'),
          body: jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'AutorizationNode': user.email
          });
      // print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.statusCode == 401) {
          createClaimError = "unauthorized";

          return false;
        } else {
          createClaimError = "Unknown Error ! ";
          return false;
        }
      }
    } catch (e) {
      error = e.toString();
      createClaimError = error;
      return false;
    }
  }

  Future<List<Claim>> getMyClaims() async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;
    if (user == null) {
      createClaimError = "unauthorized";
      return [];
    }
    final response = await http
        .get(Uri.parse('http://192.168.137.1:8080/node/claims/mine'), headers: {
      'Content-Type': 'application/json',
      'AutorizationNode': user.email
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // print(data);
      List<Claim> claims = [];
      List<User> AllTechnicians = [];
      for (var item in data) {
        // print(Claim.fromJson(item));
        claims.add(Claim.fromJson(item));
      }
      final technicians = await http
          .get(Uri.parse('http://192.168.137.1:8080/node/users'), headers: {
        'Content-Type': 'application/json',
        'AutorizationNode': user.email
      });
      final dataTech = jsonDecode(technicians.body);

      for (var item in dataTech) {
        AllTechnicians.add(User.fromJson(item));
      }
      for (var item in AllTechnicians) {
        // print(item.id);
      }
      for (var item in claims) {
        for (var tech in AllTechnicians) {
          // print(tech.id);
          // print(item.technician);
          if (tech.id == item.technician) {
            item.technician = tech.name;
          }
        }
      }
      //     for (var element in claim.statusHistory) {
      //   // print(element);
      //   final statusHis = StatusHistory.fromJson(element);
      //   print(statusHis);
      //   Future<Status> s = ClaimsService().getStatus(statusHis.old_status);
      // }
      List<StatusHistory> status = [];
      for (var element in claims) {
        // final element = StatusHistory.fromJson(item);

        for (var item in element.statusHistory) {
          final hist = StatusHistory.fromJson(item);
          final response_old_status = await http.get(
              Uri.parse(
                  'http://192.168.137.1:8080/node/status/${hist.old_status}'),
              headers: {
                'Content-Type': 'application/json',
                'AutorizationNode': user!.email
              });
          // print(response.body);
          final dataStatus = jsonDecode(response_old_status.body);
          print(dataStatus);
          final fetchStatus = Status.fromJson(dataStatus);
          print(fetchStatus);
          hist.old_status = fetchStatus.name!;
          // status.add(item);
          print(hist);
          final response_new_status = await http.get(
              Uri.parse(
                  'http://192.168.137.1:8080/node/status/${hist.new_status}'),
              headers: {
                'Content-Type': 'application/json',
                'AutorizationNode': user!.email
              });
          print(response_new_status.body);
          final dataNew = jsonDecode(response_new_status.body);
          print(dataStatus);
          final fetchNewStatus = Status.fromJson(dataStatus);
          print(fetchNewStatus);
          hist.new_status = fetchStatus.name!;
          StatusHistory res = StatusHistory(
              id: hist.id,
              new_status: hist.new_status,
              old_status: hist.old_status,
              author: hist.author,
              date: hist.date);
          status.add(res);
          // status.add(item);
          // print(hist);
          // hist.old_status = dataStatus;
          // final old = Status.fromJson(hist.old_status);

          // print(old);
          // hist.old_status = old;
          // hist.old_status = old as Map<String, dynamic>;
          // hist.old_status = old.name;
        }
        element.statusHistory = status;
      }
      print(claims);

      return claims;
    } else {
      print("error");
      return [];
    }
  }

  Future<Status> getStatus(String id) async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;

    final response = await http.get(
        Uri.parse('http://192.168.137.1:8080/node/status/' + id),
        headers: {
          'Content-Type': 'application/json',
          'AutorizationNode': user!.email
        });
    // if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    Status status = Status.fromJson(data);
    return status;
  }

  Future<List<Status>> getAllStatus() async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;
    if (user == null) {
      createClaimError = "unauthorized";
      return [];
    }
    final response = await http
        .get(Uri.parse('http://192.168.137.1:8080/node/status'), headers: {
      'Content-Type': 'application/json',
      'AutorizationNode': user.email
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      List<Claim> claims = [];

      return data;
    } else {
      print("error");
      return [];
    }
  }
}
