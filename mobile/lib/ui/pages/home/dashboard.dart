import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/ui/layout/bottom_navigation_bar.dart';
import 'package:mobile/ui/layout/navigation_menu.dart';
import 'package:mobile/ui/layout/scooter_management_layout.dart';

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
          body: SingleChildScrollView(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 252, 253, 255),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      title: const Text("Tires pressure"),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        padding: EdgeInsets.zero,
                        onSelected: (value) => showInSnackBar(
                          "text1",
                        ),
                        itemBuilder: (context) => <PopupMenuItem<String>>[
                          const PopupMenuItem<String>(
                            value: "text1",
                            child: Text(
                              "text1",
                            ),
                          ),
                          const PopupMenuItem<String>(
                            enabled: false,
                            child: Text(
                              "text2",
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: "text3",
                            child: Text(
                              "text3",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/tyre.png',
                            height: 300.0,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(255, 254, 254, 254),
                                  child: SizedBox(
                                      height: 40,
                                      width: 600,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(60, 30),
                                            fixedSize: const Size(10, 2),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 254, 254, 254)),
                                        label: const Text(
                                          "Check your front right tyre",
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 5, 5, 5)),
                                        ),
                                        icon: const Icon(Icons.warning,
                                            color: Color.fromARGB(
                                                255, 234, 26, 26),
                                            size: 18),
                                        onPressed: () {},
                                      )),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  ScooterManagement()
                ],
              ),
            ),
          )),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(this.user),
          bottomNavigationBar: bottomNav(),
        )));
  }

  showInSnackBar(demoMenuSelected) {}
}
