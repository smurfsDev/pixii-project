import 'package:latlong2/latlong.dart';
import "package:mobile/imports.dart";

class CurrentLocation extends StatefulWidget {
  final Function(LatLng, LatLng?) notifyParent;
  const CurrentLocation({
    Key? key,
    required this.mapController,
    required this.notifyParent,
  }) : super(key: key);

  final MapController mapController;

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  int _eventKey = 0;
  LatLng? _currentLocation;
  IconData icon = Icons.gps_not_fixed;
  late final StreamSubscription<MapEvent> mapEventSubscription;

  @override
  void initState() {
    super.initState();
    mapEventSubscription =
        widget.mapController.mapEventStream.listen(onMapEvent);
  }

  @override
  void dispose() {
    mapEventSubscription.cancel();
    super.dispose();
  }

  void setIcon(IconData newIcon) {
    if (newIcon != icon && mounted) {
      setState(() {
        icon = newIcon;
      });
    }
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove && mapEvent.id != _eventKey.toString()) {
      setIcon(Icons.gps_not_fixed);
    }
  }

  void _moveToCurrent() async {
    _eventKey++;
    final location = Location();

    try {
      final currentLocation = await location.getLocation();

      final moved = widget.mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        18,
        id: _eventKey.toString(),
      );
      _currentLocation =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      widget.notifyParent(
          LatLng(currentLocation.latitude!, currentLocation.longitude!),
          _currentLocation);
      setIcon(moved ? Icons.gps_fixed : Icons.gps_not_fixed);
    } catch (e) {
      setIcon(Icons.gps_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: _moveToCurrent,
    );
  }
}
