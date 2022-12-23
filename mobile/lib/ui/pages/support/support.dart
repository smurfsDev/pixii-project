import 'package:mobile/imports.dart';
import 'package:mobile/service/claims.dart';

// ignore: must_be_immutable
class Support extends StatefulWidget {
  User user;
  Support(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Support> createState() => _Support();
}

class _Support extends State<Support> {
  var index = 0;
  final _formKey = GlobalKey<FormState>();

  String title = "";
  String subject = "";
  String message = "";

  _Support();

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
        showAlert(context, 'Success', 'Claim created successfully');
      } else {
        showAlert(context, 'Error', claim.createClaimError);
      }
    }
  }

  hello() {
    print("object");
  }
}
