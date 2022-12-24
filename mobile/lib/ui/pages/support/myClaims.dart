import 'package:mobile/imports.dart';
import 'package:mobile/models/Claim.dart';
import 'package:mobile/service/claims.dart';
import 'package:mobile/ui/pages/support/oneClaim.dart';

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
  // late Future<List<Claim>> claims;

  _MyClaims(this.user);
  @override
  void initState() {
    super.initState();
    fetchClaims();
    // claims = ClaimsService().getMyClaims();

    // print(claims);
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
          body: Center(
              child: FutureBuilder(
            future: ClaimsService().getMyClaims(),
            builder: ((context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                // return Text(snapshot.data!.title);
                return getOneClaim(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }),
          )),
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
