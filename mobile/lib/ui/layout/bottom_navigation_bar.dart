// ignore_for_file: must_be_immutable

import 'package:mobile/imports.dart';

class bottomNav extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<bottomNav> createState() => _bottomNav();
}

class _bottomNav extends State<bottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 19, 27, 54),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_scooter_outlined,
                color: Color.fromARGB(255, 249, 249, 249)),
            label: 'Management',
            backgroundColor: Color.fromARGB(255, 19, 27, 54),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on,
                color: Color.fromARGB(255, 249, 249, 249)),
            label: 'Localization',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.settings, color: Color.fromARGB(255, 249, 249, 249)),
            label: 'Settings',
            backgroundColor: Color.fromARGB(255, 19, 27, 54),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,
                color: Color.fromARGB(255, 249, 249, 249)),
            label: 'Notification',
            backgroundColor: Color.fromARGB(255, 10, 17, 38),
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 234, 234, 235),
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5);
  }
}
