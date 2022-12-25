import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/models/Status.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';
import 'package:mobile/ui/pages/support/support.dart';

// ignore: must_be_immutable
class ClaimDetails extends StatefulWidget {
  Claim claim;
  User user;
  ClaimDetails(this.claim, this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ClaimDetails> createState() => _ClaimDetails(this.claim, this.user);
}

class _ClaimDetails extends State<ClaimDetails> {
  Claim claim;
  User user;

  _ClaimDetails(this.claim, this.user);
  var index = 0;
  int acceptedData = 0;
  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);
    final statusClaim = Status.fromJson(claim.status);

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('${claim.title}'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(
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
                          'Employee in charge : \n',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }
}
