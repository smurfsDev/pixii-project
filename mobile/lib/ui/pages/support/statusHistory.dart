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

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    final statusClaim = Status.fromJson(claim.status);

    List<StatusHistory>? statusHistoryTable;

    List<StatusHistory> allStatusHistory = [];
    for (var element in claim.statusHistory) {
      StatusHistory statusHistory = StatusHistory(
          id: '', author: '', new_status: '', old_status: '', date: '');
      final statusClaim = StatusHistory.fromJson(element);
      statusHistory.new_status = statusClaim.new_status;
      statusHistory.old_status = statusClaim.old_status;
      statusHistory.id = statusClaim.id;
      statusHistory.author = statusClaim.author;
      statusHistory.date = statusClaim.date;

      allStatusHistory.add(statusHistory);
    }
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView.separated(
          itemCount: allStatusHistory.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
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
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "Transaction: $index ",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "Old status: ${allStatusHistory[index].old_status} ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "New status: ${allStatusHistory[index].new_status} ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "Author:  ${allStatusHistory[index].author}  ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "Created at ${allStatusHistory[index].date!.substring(0, 10)}  ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(claim.created!.substring(0, 10),
                          style: TextStyle(color: Colors.white)),
                      onTap: () => {},
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
