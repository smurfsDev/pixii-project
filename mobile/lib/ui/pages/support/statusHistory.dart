import 'dart:convert';

import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/models/StatusHistory.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/oneClaim.dart';

// ignore: must_be_immutable
class StatusHistoryWidget extends StatefulWidget {
  User user;
  Claim claim;
  StatusHistoryWidget(this.claim, this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<StatusHistoryWidget> createState() =>
      _StatusHistoryWidget(this.claim, this.user);
}

class _StatusHistoryWidget extends State<StatusHistoryWidget> {
  User user;
  Claim claim;

  // late Future<List<Claim>> claims;

  _StatusHistoryWidget(this.claim, this.user);
  @override
  void initState() {
    super.initState();
  }

  Color oldStatusHistoryColor = Colors.red;
  Color newStatusHistoryColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    final statusClaim = Status.fromJson(claim.status);

    List<StatusHistory>? statusHistoryTable;
    List<StatusHistory> allStatusHistory = [];

    for (var element in claim.statusHistory) {
      StatusHistory statusHistory = StatusHistory(
          id: '',
          author: '',
          new_status: '',
          old_status: '',
          date: '',
          claim: '');
      final statusClaim = StatusHistory.fromJson(element);

      if (statusClaim.claim == claim.id) {
        statusHistory.new_status = statusClaim.new_status;
        statusHistory.old_status = statusClaim.old_status;
        statusHistory.id = statusClaim.id;
        statusHistory.author = statusClaim.author;
        statusHistory.date = statusClaim.date;
        allStatusHistory.add(statusHistory);
      }
    }
    List<StatusHistory> reversedStatusHistory =
        allStatusHistory.reversed.toList();
    if (reversedStatusHistory.isEmpty) {
      return Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.lightBlue,
                            size: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Status history is empty",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "You'll see the status history of this claim here when it's updated",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,),
                                  textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
    }
    return SingleChildScrollView(
        child: ListView.separated(
      itemCount: reversedStatusHistory.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        if (reversedStatusHistory[index].old_status == "DONE") {
          oldStatusHistoryColor = Colors.green;
        }
        if (reversedStatusHistory[index].old_status == "INPROGRESS") {
          oldStatusHistoryColor = Colors.orange;
        }
        if (reversedStatusHistory[index].old_status == "TODO") {
          oldStatusHistoryColor = Colors.red;
        }
        if (reversedStatusHistory[index].old_status == "STUCK") {
          oldStatusHistoryColor = Colors.blue;
        }
        if (reversedStatusHistory[index].new_status == "DONE") {
          newStatusHistoryColor = Colors.green;
        }
        if (reversedStatusHistory[index].new_status == "INPROGRESS") {
          newStatusHistoryColor = Colors.orange;
        }
        if (reversedStatusHistory[index].new_status == "TODO") {
          newStatusHistoryColor = Colors.red;
        }
        if (reversedStatusHistory[index].new_status == "STUCK") {
          newStatusHistoryColor = Colors.blue;
        }
        return Center(
          child: Card(
            color: const Color.fromARGB(255, 29, 39, 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.compare_arrows_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Transaction ${reversedStatusHistory.length - index} \n',
                          style: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Wrap(
                        children: [
                          const Text(
                            'Old status: \n',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            ' ${reversedStatusHistory[index].old_status}\n',
                            style: TextStyle(
                                color: oldStatusHistoryColor,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          const Text(
                            'New status: \n',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            ' ${reversedStatusHistory[index].new_status}\n',
                            style: TextStyle(
                                color: newStatusHistoryColor,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          const Text(
                            'Author: \n',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            ' ${reversedStatusHistory[index].author}\n',
                            style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          const Text(
                            'Created at : \n',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            ' ${reversedStatusHistory[index].date!.substring(11, 16)} on ${reversedStatusHistory[index].date!.substring(0, 10)}\n',
                            style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));
  }
}
