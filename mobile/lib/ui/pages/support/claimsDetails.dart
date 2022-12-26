import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/oneClaim.dart';

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

  // late Future<List<Claim>> claims;

  _ClaimsDetails(this.claim, this.user);
  @override
  void initState() {
    super.initState();
    // fetchClaims();
    // claims = ClaimsService().getClaimsDetails();

    // print(claims);
  }

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    final statusClaim = Status.fromJson(claim.status);
    return SingleChildScrollView(
      child: Card(
          color: Color.fromARGB(255, 45, 56, 90),
          child: Padding(
            padding: EdgeInsets.all(50),
            child: SizedBox(
              width: 400,
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Claim\n ',
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                  Text(
                    'Status: ${statusClaim.name}\n  ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Subject: ${claim.subject}\n  ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Message :${claim.message} \n',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Employee in charge :  ${claim.technician}\n',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
