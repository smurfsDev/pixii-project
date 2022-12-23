import 'dart:convert';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;
import 'package:mobile/models/Claim.dart';

class ClaimsService with ChangeNotifier {
  late Claim? claim = null;
  late String error;
  late String createClaimError;

  Future<bool> createClaim(
      String subject, String title, String message, User user) async {
    final request = {
      'subject': subject,
      'title': title,
      'message': message,
      'user': user
    };
    print("request $request");
    try {
      print("object");
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/node/claims'),
          body: jsonEncode(request),
          headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.statusCode == 401) {
          createClaimError = "unauthorized";

          return false;
        } else {
          createClaimError = "error okhra";
          return false;
        }
      }
    } catch (e) {
      error = e.toString();
      createClaimError = error;
      return false;
    }
  }
}
