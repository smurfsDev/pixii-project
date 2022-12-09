import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/ui/layout/bottom_navigation_bar.dart';
import 'package:mobile/ui/layout/navigation_menu.dart';
import 'package:mobile/ui/layout/scooter_management_layout.dart';

// ignore: must_be_immutable
class Localization extends StatefulWidget {
  User user;
  Localization(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Localization> createState() => _Localization(user);
}

class _Localization extends State<Localization> {
  User user;
  _Localization(this.user);
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
          bottomNavigationBar: bottomNav(this.user),
          drawer: NavDrawerDemo(this.user),
        )));
  }

  showInSnackBar(demoMenuSelected) {}
}
