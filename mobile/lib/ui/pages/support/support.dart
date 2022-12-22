import 'package:mobile/imports.dart';

// ignore: must_be_immutable
class Support extends StatefulWidget {
  User user;
  Support(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Support> createState() => _Support();
}

class _Support extends State<Support> {
  String password = "";
  var index = 0;
  // List<Widget> pages = <Widget>[];
  // @override
  // void initState() {
  //   super.initState();
  //   pages = [
  //     const Managment(),
  //     const Localization(),
  //     const Settings(),
  //     const Notifications()
  //   ];
  // }

  _Support();

  @override
  Widget build(BuildContext context) {
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
          body: Text("Hello world"),
          // body: SingleChildScrollView(
          //     child: Padding(
          //   padding: const EdgeInsets.all(40),
          //   child: FadeIndexedStack(
          //     key: ValueKey(1),
          //     index: index,
          //     children: pages,
          //   ),
          // )),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }
}
