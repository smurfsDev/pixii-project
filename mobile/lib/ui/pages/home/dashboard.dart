import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/models/BikeData.dart';
import 'package:mobile/service/bike.dart';
import 'package:mobile/service/claims.dart';

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
  
  late ClaimsService claimsService = ClaimsService();

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Request a Callback"),
                    content: Text("Do you want to request a callback?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("No", style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Yes", style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          requestCallback();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.phone,
                color: Color.fromARGB(255, 19, 27, 54)),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        )));
  }
  Future<void> requestCallback() async {
    final requestOK = await claimsService.requestCallback();
    Navigator.of(context).pop();
    if(requestOK){
      Fluttertoast.showToast(
        msg: "Callback requested",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    else{
      Fluttertoast.showToast(
        msg: "Callback request failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }
}
