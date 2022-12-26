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
          Uri.parse('${Environment.apiUrl}/node/claims'),
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
        .get(Uri.parse('${Environment.apiUrl}/node/claims/mine'), headers: {
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
          .get(Uri.parse('${Environment.apiUrl}/node/users'), headers: {
        'Content-Type': 'application/json',
        'AutorizationNode': user.email
      });
      final dataTech = jsonDecode(technicians.body);

      for (var item in dataTech) {
        AllTechnicians.add(User.fromJson(item));
      }
      for (var item in AllTechnicians) {
        print(item.id);
      }
      for (var item in claims) {
        for (var tech in AllTechnicians) {
          print(tech.id);
          print(item.technician);
          if (tech.id == item.technician) {
            item.technician = tech.name;
          }
        }
      }
      for (var element in claims) {
        for (var item in element.statusHistory) {
          item = StatusHistory.fromJson(item);
        }
      }
      print(claims);

      return claims;
    } else {
      print("error");
      return [];
    }
  }
}
