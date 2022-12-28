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
    print(claim.statusHistory.length);
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
      print(statusClaim);
      // print(claim.id);
      if (statusClaim.claim == claim.id) {
        statusHistory.new_status = statusClaim.new_status;
        statusHistory.old_status = statusClaim.old_status;
        statusHistory.id = statusClaim.id;
        statusHistory.author = statusClaim.author;
        statusHistory.date = statusClaim.date;
        print(statusHistory);
        allStatusHistory.add(statusHistory);
      }
    }

    print(allStatusHistory.length);

    return SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: ListView.separated(
      itemCount: allStatusHistory.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        if (allStatusHistory[index].old_status == "DONE") {
          oldStatusHistoryColor = Colors.green;
        }
        if (allStatusHistory[index].old_status == "INPROGRESS") {
          oldStatusHistoryColor = Colors.orange;
        }
        if (allStatusHistory[index].old_status == "TODO") {
          oldStatusHistoryColor = Colors.red;
        }
        if (allStatusHistory[index].old_status == "STUCK") {
          oldStatusHistoryColor = Colors.blue;
        }
        if (allStatusHistory[index].new_status == "DONE") {
          newStatusHistoryColor = Colors.green;
        }
        if (allStatusHistory[index].new_status == "INPROGRESS") {
          newStatusHistoryColor = Colors.orange;
        }
        if (allStatusHistory[index].new_status == "TODO") {
          newStatusHistoryColor = Colors.red;
        }
        if (allStatusHistory[index].new_status == "STUCK") {
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
                          'Transaction $index \n',
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
                            ' ${allStatusHistory[index].old_status}\n',
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
                            ' ${allStatusHistory[index].new_status}\n',
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
                            ' ${allStatusHistory[index].author}\n',
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
                            ' ${allStatusHistory[index].date!.substring(11, 16)} on ${allStatusHistory[index].date!.substring(0, 10)}\n',
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
