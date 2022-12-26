import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/models/StatusHistory.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/claimsDetails.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';
import 'package:mobile/ui/pages/support/support.dart';

// ignore: must_be_immutable
class ClaimsTabs extends StatefulWidget {
  Claim claim;
  User user;
  ClaimsTabs(this.claim, this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ClaimsTabs> createState() => _ClaimsTabs(this.claim, this.user);
}

class _ClaimsTabs extends State<ClaimsTabs> {
  Claim claim;
  User user;

  _ClaimsTabs(this.claim, this.user);
  var index = 0;
  int acceptedData = 0;
  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    final statusClaim = Status.fromJson(claim.status);
    var history = [];
    for (var element in claim.statusHistory) {
      print(element);
      final statusHis = StatusHistory.fromJson(element);

      // history.add(statusHis);
    }

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text("Details"),
                  ),
                  Tab(
                    child: Text("Status History"),
                  ),
                  Tab(
                    child: Text("Comments"),
                  ),
                ],
              ),
              title: const Text('Tabs Demo'),
            ),
            body: TabBarView(
              children: [
                ClaimsDetails(claim, user),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
            drawer: NavDrawerDemo(widget.user),
          ),
        )));
  }
}
