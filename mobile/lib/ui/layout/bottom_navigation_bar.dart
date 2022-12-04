// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/imports.dart';

class bottomNav extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<bottomNav> createState() => _bottomNav();
}

class _bottomNav extends State<bottomNav> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.blueAccent,
      items: const <Widget>[
        Icon(Icons.bike_scooter, size: 30),
        Icon(Icons.location_on, size: 30),
        Icon(Icons.settings, size: 30),
        Icon(Icons.notifications, size: 30),
      ],
      onTap: (index) {
        //Handle button tap
      },
    );
  }
}
