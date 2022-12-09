import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/ui/layout/bottom_navigation_bar.dart';
import 'package:mobile/ui/layout/navigation_menu.dart';
import 'package:mobile/ui/layout/scooter_management_layout.dart';

// ignore: must_be_immutable
class Localization extends StatefulWidget {
  Localization({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Localization> createState() => _Localization();
}

class _Localization extends State<Localization> {
  String image = 'assets/images/tyre.png';

  String titleMenu = "Tires pressure";
  String messagePopUpMenu = "Check your front right tyre";
  IconData? iconPopUpElement = Icons.warning;
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
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          bottomNavigationBar: bottomNav(),
        )));
  }

  showInSnackBar(demoMenuSelected) {}
}
