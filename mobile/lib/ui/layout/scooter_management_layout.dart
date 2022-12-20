// ignore_for_file: must_be_immutable

import 'package:mobile/imports.dart';
import 'package:mobile/models/BikeData.dart';
import 'package:mobile/service/bike.dart';

class ScooterManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScooterManagmentState();
}

class _ScooterManagmentState extends State<ScooterManagement> {
  late BikeData? bike = null;
  late BikeService bikeService;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bikeService = Provider.of<BikeService>(context, listen: false);
      bike = bikeService.bikeData;
      print("State" + bikeService.bikeData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bikeService = Provider.of<BikeService>(context, listen: false);
      bike = bikeService.bikeData;
      print("State" + bikeService.bikeData.toString());
    });
    // var bikeService = Provider.of<BikeService>(context, listen: false);
    // bike = bikeService.bikeData;
    // print(bike!.TheftState);
    if (bike == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
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
                        onPressed: () {
                          bikeService.LockBike(true)
                              .then((value) => setState(() {
                                    bike = bikeService.bikeData!;
                                  }));
                        },
                        child: IconButton(
                          iconSize: 20,
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: Icon(
                            Icons.lock_outline,
                            color: bike != null
                                ? !bike!.TheftState
                                    ? Color.fromARGB(255, 81, 66, 64)
                                    : Color.fromARGB(255, 224, 44, 32)
                                : Color.fromARGB(255, 224, 44, 32),
                          ),
                          onPressed: () {
                            bikeService.LockBike(true)
                                .then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                          },
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
                        onPressed: () {
                          bikeService.LockBike(false).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                        },
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: Icon(
                            Icons.lock_open_outlined,
                            color: bike != null
                                ? bike!.TheftState
                                    ? Color.fromARGB(255, 81, 66, 64)
                                    : Color.fromARGB(255, 224, 44, 32)
                                : Color.fromARGB(255, 224, 44, 32),
                          ),
                          onPressed: () {
                            bikeService.LockBike(false).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                          },
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
                        onPressed: () {
                          bikeService.ChangeLightState(false).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                        },
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: Icon(
                            Icons.light_mode_outlined,
                            color: bike != null
                                ? bike!.LightState
                                    ? Color.fromARGB(255, 81, 66, 64)
                                    : Color.fromARGB(255, 224, 44, 32)
                                : Color.fromARGB(255, 224, 44, 32),
                          ),
                          onPressed: () {
                            bikeService.ChangeLightState(false).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                          },
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
                        onPressed: () {
                          bikeService.ChangeLightState(true).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                        },
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: Icon(
                            Icons.light_mode_rounded,
                            color: bike != null
                                ? !bike!.LightState
                                    ? Color.fromARGB(255, 81, 66, 64)
                                    : Color.fromARGB(255, 224, 44, 32)
                                : Color.fromARGB(255, 224, 44, 32),
                          ),
                          onPressed: () {
                            bikeService.ChangeLightState(true).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                          },
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
                        onPressed: () {
                          bikeService.ChangeAlarmState(false).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                        },
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: Icon(
                            Icons.notifications_off,
                            color: bike != null
                                ? bike!.AlarmState
                                    ? Color.fromARGB(255, 81, 66, 64)
                                    : Color.fromARGB(255, 224, 44, 32)
                                : Color.fromARGB(255, 224, 44, 32),
                          ),
                          onPressed: () {
                            bikeService.ChangeAlarmState(false).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                          },
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
                        onPressed: () {
                          bikeService.ChangeAlarmState(true).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                        },
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          color: const Color.fromARGB(255, 244, 246, 249),
                          icon: Icon(
                            Icons.notifications_on,
                            color: bike != null
                                ? !bike!.AlarmState
                                    ? Color.fromARGB(255, 81, 66, 64)
                                    : Color.fromARGB(255, 224, 44, 32)
                                : Color.fromARGB(255, 224, 44, 32),
                          ),
                          onPressed: () {
                            bikeService.ChangeAlarmState(true).then((value) => setState(() {
                                      bike = bikeService.bikeData!;
                                    }));
                          },
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
      );
    }
  }
}
