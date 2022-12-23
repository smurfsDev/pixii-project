import 'package:mobile/imports.dart';
import 'package:mobile/service/claims.dart';

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
  Widget build(BuildContext context) {
    final claimsService = Provider.of<ClaimsService>(context);

    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('MyClaims'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(child: Text("My claims")),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }
}
