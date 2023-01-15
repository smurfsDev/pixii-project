import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';
import 'package:mobile/ui/pages/support/oneClaim.dart';
import 'package:mobile/ui/pages/support/support.dart';

// ignore: must_be_immutable
class ClaimsDetails extends StatefulWidget {
  User user;
  Claim claim;
  ClaimsDetails(this.claim, this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ClaimsDetails> createState() => _ClaimsDetails(this.claim, this.user);
}

class _ClaimsDetails extends State<ClaimsDetails> {
  User user;
  Claim claim;

  _ClaimsDetails(this.claim, this.user);
  @override
  void initState() {
    super.initState();
  }

  Color claimStatusColor = Colors.red;
  String employee = "";

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    final statusClaim = Status.fromJson(claim.status);
    if (statusClaim.name == "DONE") {
      claimStatusColor = Colors.green;
    }
    if (statusClaim.name == "INPROGRESS") {
      claimStatusColor = Colors.orange;
    }
    if (statusClaim.name == "TODO") {
      claimStatusColor = Colors.red;
    }
    if (statusClaim.name == "STUCK") {
      claimStatusColor = Colors.blue;
    }
    if (claim.technician == null) {
      employee = "Not yet affected";
    } else {
      employee = claim.technician!;
    }
    return SingleChildScrollView(
      child: Card(
          color: Color.fromARGB(255, 29, 39, 70),
          child: Padding(
            padding: EdgeInsets.all(50),
            child: SizedBox(
              width: 400,
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Claim details: \n',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Status: \n',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        ' ${statusClaim.name}\n',
                        style: TextStyle(
                            color: claimStatusColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Subject \n',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        ' ${claim.subject}\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Description :\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        ' ${claim.message}\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  // Wrap(
                  //   children: [
                  //     Text(
                  //       'Employee in charge: \n',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ),
                  //     Text(
                  //       ' ${employee}\n',
                  //       style: const TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.normal,
                  //           fontSize: 16),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}
