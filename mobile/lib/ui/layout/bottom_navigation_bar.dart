// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/imports.dart';

class bottomNav extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<bottomNav> createState() => _bottomNav();
}

class _bottomNav extends State<bottomNav> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color.fromARGB(255, 19, 27, 54),
      items: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.electric_scooter_outlined,
                size: 30,
                color: _selectedIndex == 0
                    ? Colors.black
                    : Color.fromARGB(255, 171, 160, 160)),
            Text(
              "Management",
              style: TextStyle(
                fontSize: _selectedIndex == 0 ? 0 : 12,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on,
                size: 30,
                color: _selectedIndex == 1
                    ? Colors.black
                    : Color.fromARGB(255, 171, 160, 160)),
            Text(
              "Localization",
              style: TextStyle(
                fontSize: _selectedIndex == 1 ? 1 : 12,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings,
                size: 30,
                color: _selectedIndex == 2
                    ? Colors.black
                    : Color.fromARGB(255, 171, 160, 160)),
            Text(
              "Settings",
              style: TextStyle(
                fontSize: _selectedIndex == 2 ? 2 : 12,
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_on_sharp,
                size: 30,
                color: _selectedIndex == 3
                    ? Colors.black
                    : Color.fromARGB(255, 171, 160, 160)),
            Text(
              "Notifications",
              style: TextStyle(
                fontSize: _selectedIndex == 3 ? 3 : 12,
              ),
            )
          ],
        ),
      ],
      onTap: (index) {
        _onItemTapped(index);
        //Handle button tap
      },
    );
  }
}
