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
    // final statusClaim = Status.fromJson(claim.status);
    final statusClaim = Status.fromJson(claim.status);
    var history = [];
    Status? ss;
    print(claim);

    List<StatusHistory>? statusHistoryTable;
    print(claim.statusHistory.length);

    print(statusClaim);
    var old_status;

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView.separated(
          itemCount: 10,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            // final tableHist = statusHistoryTable![index];
            for (var element in claim.statusHistory) {
              final statusClaim = StatusHistory.fromJson(element);
              old_status = statusClaim.old_status;
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Old status: ${old_status}    \t New status:  ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "New status:  ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      // trailing: Text(claim.created!.substring(0, 10),
                      //       style: TextStyle(color: Colors.white)),
                      //   onTap: () => {},
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
