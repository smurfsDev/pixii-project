// ignore_for_file: must_be_immutable

import 'package:mobile/imports.dart';

class ScooterManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(60, 30),
                          fixedSize: const Size(10, 2),
                          backgroundColor:
                              const Color.fromARGB(255, 254, 254, 254),
                        ),
                        onPressed: () {},
                        child: IconButton(
                          iconSize: 20,
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: const Icon(Icons.lock_outline,
                              color: Color.fromARGB(255, 224, 44, 32)),
                          onPressed: () {},
                        ),
                      ),
                      const Text(
                        "Lock",
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 246, 249)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(60, 30),
                          fixedSize: const Size(10, 2),
                          backgroundColor:
                              const Color.fromARGB(255, 254, 254, 254),
                        ),
                        onPressed: () {},
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: const Icon(Icons.lock_open_outlined,
                              color: Color.fromARGB(255, 224, 44, 32)),
                          onPressed: () {},
                        ),
                      ),
                      const Text(
                        "Unlock",
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 246, 249)),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(60, 30),
                          fixedSize: const Size(10, 2),
                          backgroundColor:
                              const Color.fromARGB(255, 254, 254, 254),
                        ),
                        onPressed: () {},
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: const Icon(Icons.light_mode_outlined,
                              color: Color.fromARGB(255, 224, 44, 32)),
                          onPressed: () {},
                        ),
                      ),
                      const Text(
                        "Light off",
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 246, 249)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(60, 30),
                          fixedSize: const Size(10, 2),
                          backgroundColor:
                              const Color.fromARGB(255, 254, 254, 254),
                        ),
                        onPressed: () {},
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: const Icon(Icons.light_mode_rounded,
                              color: Color.fromARGB(255, 224, 44, 32)),
                          onPressed: () {},
                        ),
                      ),
                      const Text(
                        "Light on",
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 246, 249)),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(60, 30),
                          fixedSize: const Size(10, 2),
                          backgroundColor:
                              const Color.fromARGB(255, 254, 254, 254),
                        ),
                        onPressed: () {},
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: const Icon(Icons.notifications_off,
                              color: Color.fromARGB(255, 224, 44, 32)),
                          onPressed: () {},
                        ),
                      ),
                      const Text(
                        "Alarm off",
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 246, 249)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(60, 30),
                          fixedSize: const Size(10, 2),
                          backgroundColor:
                              const Color.fromARGB(255, 254, 254, 254),
                        ),
                        onPressed: () {},
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: const Icon(Icons.notifications_on,
                              color: Color.fromARGB(255, 224, 44, 32)),
                          onPressed: () {},
                        ),
                      ),
                      const Text(
                        "Alarm on",
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 246, 249)),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
