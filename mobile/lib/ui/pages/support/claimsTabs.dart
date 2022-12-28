import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/models/StatusHistory.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/claimsDetails.dart';
import 'package:mobile/ui/pages/support/comments.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';
import 'package:mobile/ui/pages/support/statusHistory.dart';
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
    print(claim);

    return (MaterialApp(
        theme: ThemeData(
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            labelStyle: TextStyle(color: Colors.white),
          ),
          primaryColor: Color.fromARGB(255, 5, 1, 3),
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 19, 27, 54),
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
              title: Text(claim.title),
            ),
            body: TabBarView(
              children: [
                ClaimsDetails(claim, user),
                StatusHistoryWidget(claim, user),
                Comments(claim, user),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
            drawer: NavDrawerDemo(widget.user),
          ),
        )));
  }
}
