import 'package:mobile/imports.dart';
import 'package:mobile/service/bike.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  User user;
  Dashboard(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  String password = "";
  var index = 0;
  List<Widget> pages = <Widget>[];
  late BikeService bikeService;
  @override
  void initState() {
    super.initState();
    pages = [
      const Managment(),
      const Localization(),
      const Settings(),
      const Notifications()
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bikeService = Provider.of<BikeService>(context, listen: false);
      bikeService.getBikeData();
    });
  }

  _Dashboard();

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
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: FadeIndexedStack(
              key: ValueKey(1),
              index: index,
              children: pages,
            ),
          )),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
          bottomNavigationBar: bottomNav(
            callback: (int i) => setState(() => index = i),
          ),
        )));
  }
}
