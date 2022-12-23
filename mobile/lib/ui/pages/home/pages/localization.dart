import 'package:latlong2/latlong.dart';
import "package:mobile/imports.dart";
import 'package:mobile/models/BikeData.dart';
import 'package:mobile/service/bike.dart';
import 'package:mobile/ui/components/current_location.dart';

class Localization extends StatefulWidget {
  const Localization({Key? key}) : super(key: key);

  @override
  _LocalizationState createState() => _LocalizationState();
}

class _LocalizationState extends State<Localization> {
  LatLng bike = LatLng(37.235693, 9.883512);
  double _rotation = 0;
  late final MapController _mapController;
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => {_mapController.fitBounds(LatLngBounds(bike))});

    markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: bike,
        builder: (ctx) => Container(
            key: const Key('purple'),
            // marker icon location Icon
            child: Column(
              children: const [
                Icon(
                  Icons.electric_bike,
                  color: Colors.purple,
                  size: 40,
                ),
                Text("My bike")
              ],
            )),
      ),
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var bikeService = Provider.of<BikeService>(context, listen: false);
      BikeData? bk = bikeService.bikeData;
      if (bk == null) 
      await bikeService.getBikeData();
      bk = bikeService.bikeData;

        print(bk!.location['latitude']);
        // refresh the map
        setState(() {
          bike = LatLng(bk!.location['latitude'], bk!.location['longitude']);
          markers = [Marker(
            width: 80,
            height: 80,
            point: bike,
            builder: (ctx) => Container(
                key: const Key('purple'),
                // marker icon location Icon
                child: Column(
                  children: const [
                    Icon(
                      Icons.electric_bike,
                      color: Colors.purple,
                      size: 40,
                    ),
                    Text("My bike")
                  ],
                )),
          )];
        });
        _mapController.move(bike, 15);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            "Localization",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 5, 5, 5),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                child: Container(
                    // here
                    height: 500,
                    alignment: Alignment.centerLeft,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: bike,
                        zoom: 5,
                      ),
                      nonRotatedChildren: [
                        FlutterMapButtons(
                          minZoom: 4,
                          maxZoom: 19,
                          mini: true,
                          padding: 10,
                          alignment: Alignment.bottomRight,
                          child: CurrentLocation(
                              mapController: _mapController,
                              notifyParent: (LatLng nw, LatLng? old) {
                                setState(() {});
                                if (old != null) {
                                  if (old != nw) {
                                    markers.forEach((element) {
                                      if (element.point == old) {
                                        markers.remove(element);
                                      }
                                    });
                                  }
                                }
                                markers.add(Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: nw,
                                  builder: (ctx) => Container(
                                    key: const Key('home'),
                                    child: const Icon(
                                      Icons.home,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                  ),
                                ));
                              }),
                        ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://a.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png ',
                        ),
                        MarkerLayer(markers: markers),
                      ],
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: const Color.fromARGB(255, 252, 253, 255),
                    onPressed: () {
                      final bounds = LatLngBounds();
                      markers.forEach((marker) {
                        bounds.extend(marker.point);
                      });
                      _mapController.fitBounds(
                        bounds,
                        options: const FitBoundsOptions(
                          padding: EdgeInsets.only(left: 15, right: 15),
                        ),
                      );
                    },
                    child: const Text('Center map'),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
