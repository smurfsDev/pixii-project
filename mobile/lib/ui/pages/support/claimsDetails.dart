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
  final _formKey = GlobalKey<FormState>();
  String message = "";
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
                  IconTheme(
                    data: IconThemeData(color: Theme.of(context).accentColor),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Flexible(
                              child: TextFormField(
                                onChanged: (value) => {
                                  setState(
                                    () {
                                      message = value;
                                    },
                                  )
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ("please enter a message of your claim");
                                  }
                                  return null;
                                },
                                // controller: _textController,
                                // onSubmitted: _handleSubmitted,
                                decoration: InputDecoration.collapsed(
                                    fillColor: Colors.white,
                                    hintText: "Send a comment"),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () => {addComment(claimsService)}),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  addComment(ClaimsService claimsService) async {
    print(message);
    if (_formKey.currentState!.validate()) {
      final commentCreated =
          await claimsService.createComment(this.claim.id, message);

      if (commentCreated) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("message"),
          backgroundColor: Colors.red,
        ));
        showDialog<void>(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Claim created'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Comment created'),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        showAlert(context, 'Error', claimsService.createClaimError);
      }
    }
  }
  // addComment() {
  //   print(message);
  //   print(claim.id);
  // }
}
