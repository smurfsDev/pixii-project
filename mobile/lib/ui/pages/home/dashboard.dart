import 'package:mobile/imports.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  User user;
  Dashboard(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Dashboard> createState() => _Dashboard(user);
}

class _Dashboard extends State<Dashboard> {
  String password = "";
  User user;
  String image = 'assets/images/tyre.png';
  String titleMenu = "Tires pressure";
  String messagePopUpMenu = "Check your front right tyre";
  IconData? iconPopUpElement = Icons.warning;
  var index = 0;
  List<Widget> pages = <Widget>[];
  @override
  void initState() {
    print("initState");
    super.initState();
    
    super.initState();
    pages = [
      const Managment(),
      const Localization(),
      const Settings(),
      const Notifications()
    ];
  }

  _Dashboard(this.user);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('Shawdow\nControl Panel'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Padding(
                padding: const EdgeInsets.all(40),
                child: FadeIndexedStack(
                  key: ValueKey(1),
                  index: index,
                  children: pages,
                )),
          )),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(this.user),
          bottomNavigationBar: bottomNav(
            callback: (int i) => setState(() => index = i),
          ),
        )));
  }

}
