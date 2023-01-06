import 'package:mobile/imports.dart';
import 'package:mobile/models/BikeData.dart';
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
  late BikeService bikeService = BikeService();
  late BikeData? bike = null;

  void init() {
     var fetch = bikeService
        .getBikeData()
        .then((value) => {
            setState(() {
              bike = bikeService.bikeData;
            }),
              pages = [
                Managment(
                  bike: bikeService.bikeData,
                  bikeService: bikeService,
                ),
                Localization(
                  bike: bikeService.bikeData,
                  bikeService: bikeService,
                ),
                const Settings(),
                const Notifications()
              ]
            })
        .catchError((err) => {
           pages = [
                Managment(
                  bike: null,
                  bikeService: bikeService,
                ),
                Localization(
                  bike: null,
                  bikeService: bikeService,
                ),
                const Settings(),
                const Notifications()
              ]
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bikeService = Provider.of<BikeService>(context, listen: false);
    bike = bikeService.bikeData;
    init();
  }

  @override
  void didUpdateWidget(covariant Dashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    bikeService = Provider.of<BikeService>(context, listen: false);
    bike = bikeService.bikeData;
    init();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void reassemble() {
    super.reassemble();
    init();

  }

  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await bikeService.getBikeData();
      init();

    });
   
  }

  _Dashboard();

  @override
  Widget build(BuildContext context) {
    // bikeService = Provider.of<BikeService>(context, listen: false);
    // bike = bikeService.bikeData;
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
