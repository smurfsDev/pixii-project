import 'dart:collection';
import 'dart:convert';

import "package:mobile/imports.dart";
import 'package:http/http.dart' as http;
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Comment.dart';
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
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/node/claims'),
          body: jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'AutorizationNode': user.email
          });
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

      List<Claim> claims = [];
      List<User> AllTechnicians = [];
      for (var item in data) {
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
      for (var item in AllTechnicians) {}
      for (var item in claims) {
        for (var tech in AllTechnicians) {
          if (tech.id == item.technician) {
            item.technician = tech.name;
          }
        }
      }

      List<Map<String, dynamic>> comments = [];
      for (var element in claims) {
        for (var item in element.comments) {
          final response_comment = await http.get(
              Uri.parse('${Environment.apiUrl}/node/comments/${item}'),
              headers: {
                'Content-Type': 'application/json',
                'AutorizationNode': user!.email
              });
          final dataComment = jsonDecode(response_comment.body);
          final fetchComment = Comment.fromJson(dataComment);
          item = fetchComment;

          if (fetchComment.claim == element.id) {
            for (var element in AllTechnicians) {
              if (element.id == fetchComment.user) {
                fetchComment.user = element.name;
              }
            }
            Map<String, dynamic> resComment = new HashMap<String, dynamic>();
            resComment = {
              "id": fetchComment.id,
              "message": fetchComment.message,
              "user": fetchComment.user,
              "claim": fetchComment.claim,
              "created": fetchComment.created
            };
            comments.add(resComment);
            element.comments = comments;
          }
        }
      }

      List<Map<String, dynamic>> status = [];
      for (var element in claims) {
        for (var item in element.statusHistory) {
          final hist = StatusHistory.fromJson(item);
          final response_old_status = await http.get(
              Uri.parse('${Environment.apiUrl}/node/status/${hist.old_status}'),
              headers: {
                'Content-Type': 'application/json',
                'AutorizationNode': user!.email
              });
          final dataOldStatus = jsonDecode(response_old_status.body);
          final fetchOldStatus = Status.fromJson(dataOldStatus);
          hist.old_status = fetchOldStatus.name!;
          final response_new_status = await http.get(
              Uri.parse('${Environment.apiUrl}/node/status/${hist.new_status}'),
              headers: {
                'Content-Type': 'application/json',
                'AutorizationNode': user!.email
              });
          final dataNewStatus = jsonDecode(response_new_status.body);
          final fetchNewStatus = Status.fromJson(dataNewStatus);
          hist.new_status = fetchNewStatus.name!;
          for (var element in AllTechnicians) {
            if (element.id == hist.author) {
              hist.author = element.name;
            }
          }
          Map<String, dynamic> res = new HashMap<String, dynamic>();
          res = {
            "id": hist.id,
            "new_status": hist.new_status,
            "old_status": hist.old_status,
            "author": hist.author,
            "date": hist.date,
            "claim": element.id
          };
          StatusHistory statHis = StatusHistory.fromJson(res);

          status.add(res);
        }

        element.statusHistory = status;
      }

      return claims;
    } else {
      return [];
    }
  }

  Future<Status> getStatus(String id) async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;

    final response = await http
        .get(Uri.parse('${Environment.apiUrl}/node/status/' + id), headers: {
      'Content-Type': 'application/json',
      'AutorizationNode': user!.email
    });
    final data = jsonDecode(response.body);
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
        .get(Uri.parse('${Environment.apiUrl}/node/status'), headers: {
      'Content-Type': 'application/json',
      'AutorizationNode': user.email
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Claim> claims = [];
      return data;
    } else {
      return [];
    }
  }

  Future<bool> createComment(String claim, String message) async {
    AuthService authService = AuthService();
    await authService.loadSettings();
    final user = authService.user;
    if (user == null) {
      createClaimError = "unauthorized";
      return false;
    }
    final request = {'message': message, 'claim': claim, 'user': user};
    try {
      final response = await http.post(
          Uri.parse('${Environment.apiUrl}/node/comments'),
          body: jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'AutorizationNode': user.email
          });
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
}
