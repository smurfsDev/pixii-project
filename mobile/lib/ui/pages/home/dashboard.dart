import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/ui/layout/navigation_menu.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  User user;
  Dashboard(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Dashboard> createState() => _Dashboard(user);
}

class _Dashboard extends State<Dashboard> {
  String password = "";
  User user;
  _Dashboard(this.user);
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
            body: Text(user.name),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
            drawer: NavDrawerDemo(this.user))));
  }
}
