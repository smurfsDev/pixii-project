import "package:mobile/imports.dart";
import 'package:mobile/models/BikeData.dart';
import 'package:mobile/service/bike.dart';

class Managment extends StatefulWidget {
  late BikeService bikeService;
  late BikeData? bike = null;
  Managment({required this.bikeService, required this.bike, Key? key})
      : super(key: key);

  @override
  _ManagmentState createState() => _ManagmentState();
}

class _ManagmentState extends State<Managment> {
  String image = 'assets/images/tyre.png';
  String titleMenu = "Tires pressure";
  String messagePopUpMenu = "Check your front right tyre";
  IconData? iconPopUpElement = Icons.warning;

  showInSnackBar(demoMenuSelected) {}
  late BikeService bikeService = widget.bikeService;
  late BikeData? bike = widget.bike;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (bike == null) {
        bike = bikeService.bikeData;
        print("State" + bikeService.toString());
        if (bike == null) {
          await bikeService.getBikeData();
          // .then((value) {
          print("fetching");
          setState(() {
            bike = bikeService.bikeData;
          });
          print("State" + bike.toString());
          // });
        } else {
          print("State" + bike!.TheftState.toString());
        }
      }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    bikeService = Provider.of<BikeService>(context, listen: false);
    bike = bikeService.bikeData;

    return Column(mainAxisSize: MainAxisSize.max, children: [
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 252, 253, 255),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(50)),
          title: Text(
            "Tires pressure",
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down_outlined),
            padding: EdgeInsets.zero,
            onSelected: (value) => showInSnackBar(
              "text1",
            ),
            itemBuilder: (context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: "Tires pressure",
                child: const Text(
                  "Tires pressure",
                ),
                onTap: () => setState(() {
                  titleMenu = "Tires pressure";
                  image = "assets/images/tyre.png";
                  messagePopUpMenu = "Check your front right tyre";
                  iconPopUpElement = Icons.warning;
                }),
              ),
              PopupMenuItem<String>(
                value: "Battery level",
                child: Text(
                  "Battery level",
                ),
                onTap: () => setState(() {
                  titleMenu = "Battery level";
                  image = "assets/images/battery_level.png";
                  messagePopUpMenu =
                      (bike?.batteryHistory.last['value'][1]).toString() + "%";
                  iconPopUpElement = Icons.battery_5_bar;
                }),
              ),
              PopupMenuItem<String>(
                enabled: true,
                value: "Elec",
                child: Text(
                  "Electricity consumption",
                ),
                onTap: () => setState(() {
                  titleMenu = "Electricity consumption";
                  image = "assets/images/electricity.png";
                  messagePopUpMenu = "0.5kWh";
                  iconPopUpElement = Icons.electric_bolt_outlined;
                }),
                // onTap: toElectricityConsumption(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            image,
            height: 300.0,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    height: 40,
                    width: 600,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 247, 247, 247)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      label: Text(
                        messagePopUpMenu,
                        style: TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
                      ),
                      icon: Icon(iconPopUpElement,
                          color: Color.fromARGB(255, 234, 26, 26), size: 18),
                      onPressed: () {},
                    ))
              ],
            ),
          ),
        ]),
      ),
      ScooterManagement(
        bike: bike,
        bikeService: bikeService,
      )
    ]);
  }
}
