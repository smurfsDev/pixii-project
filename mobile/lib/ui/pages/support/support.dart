import 'package:mobile/imports.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';

// ignore: must_be_immutable
class Support extends StatefulWidget {
  User user;
  Support(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Support> createState() => _Support(this.user);
}

class _Support extends State<Support> {
  var index = 0;
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String subject = "";
  String message = "";
  User user;

  _Support(this.user);

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('Support'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'Send reclamation',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      onChanged: (value) => {
                        setState(
                          () {
                            subject = value;
                          },
                        )
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("please enter a subject of your claim");
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Subject',
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      onChanged: (value) => {
                        setState(
                          () {
                            title = value;
                          },
                        )
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("please enter a title of your claim");
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Title',
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                        width: 400.0,
                        height: 200.0,
                        child: TextFormField(
                          maxLines: 10,
                          onChanged: (value) => {
                            setState(
                              () {
                                message = value;
                              },
                            )
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("please enter a message ");
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Type here ...',
                          ),
                        ))),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(224, 0, 119, 182)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  label: const Text(
                    "Send",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
                  ),
                  icon: const Icon(Icons.add,
                      color: Color.fromARGB(255, 255, 255, 255), size: 18),
                  onPressed: () {
                    addClaim(claimsService);
                  },
                ),
              ]),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }

  addClaim(ClaimsService claim) async {
    if (_formKey.currentState!.validate()) {
      final claimCreated = await claim.createClaim(subject, title, message);

      if (claimCreated) {
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
                    Text('Do you like to consult your claims status?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyClaims(user)));
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    _formKey.currentState?.reset();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showAlert(context, 'Error', claim.createClaimError);
      }
    }
  }
}
