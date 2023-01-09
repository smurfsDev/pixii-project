import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/oneClaim.dart';
import 'package:mobile/ui/pages/support/support.dart';

// ignore: must_be_immutable
class MyClaims extends StatefulWidget {
  User user;
  MyClaims(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<MyClaims> createState() => _MyClaims(this.user);
}

class _MyClaims extends State<MyClaims> {
  User user;

  _MyClaims(this.user);
  @override
  void initState() {
    super.initState();
    fetchClaims();
  }

  @override
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('My Claims'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
              future: ClaimsService().getMyClaims(),
              builder: ((context, snapshot) {
                if (snapshot.data?.length == 0) {
                  return
                      Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "No claims found",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "You can create a new claim by clicking on the button below",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,),
                                  textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(223, 7, 133, 200)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            label: const Text(
                              "Create new claim",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 253, 253)),
                            ),
                            icon: const Icon(Icons.add,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 18),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Support(user)));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return getOneClaim(snapshot.data!, user);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
          // ),
          // ),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }

  void fetchClaims() async {
    Future<List<Claim>> myclaims = ClaimsService().getMyClaims();
  }
}
