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
                              'assets/images/avatar.jpg',
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 254, 254, 254),
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
                                                color: Color.fromARGB(
                                                    255, 5, 5, 5)),
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
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 50, left: 15),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 30),
                                        fixedSize: const Size(10, 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 254, 254, 254),
                                      ),
                                      onPressed: () {},
                                      child: IconButton(
                                        padding: const EdgeInsets.all(2),
                                        color: const Color.fromARGB(
                                            255, 244, 246, 249),
                                        icon: const Icon(
                                            Icons.lock_open_outlined,
                                            color: Color.fromARGB(
                                                255, 224, 44, 32)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const Text(
                                      "Unlock",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 246, 249)),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 50, left: 15),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 30),
                                        fixedSize: const Size(10, 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 254, 254, 254),
                                      ),
                                      onPressed: () {},
                                      child: IconButton(
                                        padding: const EdgeInsets.all(2),
                                        color: const Color.fromARGB(
                                            255, 244, 246, 249),
                                        icon: const Icon(
                                            Icons.light_mode_outlined,
                                            color: Color.fromARGB(
                                                255, 224, 44, 32)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const Text(
                                      "Light off",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 246, 249)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 15, left: 90),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 30),
                                        fixedSize: const Size(10, 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 254, 254, 254),
                                      ),
                                      onPressed: () {},
                                      child: IconButton(
                                        iconSize: 20,
                                        padding: const EdgeInsets.all(2),
                                        color: const Color.fromARGB(
                                            255, 244, 246, 249),
                                        icon: const Icon(Icons.lock_outline,
                                            color: Color.fromARGB(
                                                255, 224, 44, 32)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const Text(
                                      "Lock",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 246, 249)),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 15, left: 90),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 30),
                                        fixedSize: const Size(10, 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 254, 254, 254),
                                      ),
                                      onPressed: () {},
                                      child: IconButton(
                                        padding: const EdgeInsets.all(2),
                                        color: const Color.fromARGB(
                                            255, 244, 246, 249),
                                        icon: const Icon(
                                            Icons.light_mode_rounded,
                                            color: Color.fromARGB(
                                                255, 224, 44, 32)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const Text(
                                      "Light on",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 246, 249)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 50, left: 15),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 30),
                                        fixedSize: const Size(10, 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 254, 254, 254),
                                      ),
                                      onPressed: () {},
                                      child: IconButton(
                                        padding: const EdgeInsets.all(2),
                                        color: const Color.fromARGB(
                                            255, 244, 246, 249),
                                        icon: const Icon(
                                            Icons.notifications_off,
                                            color: Color.fromARGB(
                                                255, 224, 44, 32)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const Text(
                                      "Alarm off",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 246, 249)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 15, left: 90),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 30),
                                        fixedSize: const Size(10, 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 254, 254, 254),
                                      ),
                                      onPressed: () {},
                                      child: IconButton(
                                        padding: const EdgeInsets.all(2),
                                        color: const Color.fromARGB(
                                            255, 244, 246, 249),
                                        icon: const Icon(Icons.notifications_on,
                                            color: Color.fromARGB(
                                                255, 224, 44, 32)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    const Text(
                                      "Alarm on",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 244, 246, 249)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
            drawer: NavDrawerDemo(this.user))));
  }

  showInSnackBar(demoMenuSelected) {}
}
