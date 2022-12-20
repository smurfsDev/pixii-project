import 'dart:collection';
import 'dart:convert';
class Location{
  late double latitude;
  late double longitude;
  late double altitude;
  late double heading;
  late double speed;
  late double accuracy;
  Location({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.accuracy,
  });
}
class BatteryHistory{
  late DateTime date;
  // array of any
  late List value;
  BatteryHistory({
    required this.date,
    required this.value,
  });
}
class BikeData {
  late String id;
	late bool SysPower;
	late DateTime date;
	late LinkedHashMap<String, dynamic> location;
	late bool BatteryStatus;
	late int BatteryCap;
	late List<dynamic> batteryHistory;
	late int Range;
	late bool BluetoothOp;
	late bool BluetoothCon;
	late bool TheftState;
	late bool SystemSOS;
	late bool UserSOS;

  BikeData({
    required this.id,
    required this.SysPower,
    required this.date,
    required this.location,
    required this.BatteryStatus,
    required this.BatteryCap,
    required this.batteryHistory,
    required this.Range,
    required this.BluetoothOp,
    required this.BluetoothCon,
    required this.TheftState,
    required this.SystemSOS,
    required this.UserSOS,
  });

    // factory User.fromJson(Map<String, dynamic> json) => User(
    //     username: json["username"],
    //     name: json["name"],
    //   );
    factory BikeData.fromJson(Map<String, dynamic> json) => BikeData(
        id: json["id"],
        SysPower: json["SysPower"],
        date: DateTime.parse(json["date"]),
        location: json["location"],
        BatteryStatus: json["BatteryStatus"],
        BatteryCap: json["BatteryCap"],
        batteryHistory: json["BatteryHistory"],
        Range: json["Range"],
        BluetoothOp: json["BluetoothOp"],
        BluetoothCon: json["BluetoothCon"],
        TheftState: json["TheftState"],
        SystemSOS: json["SystemSOS"],
        UserSOS: json["UserSOS"],
      );

    Map<String, dynamic> toJson() => {
        "id": id,
        "SysPower": SysPower,
        "date": date,
        "location": location,
        "BatteryStatus": BatteryStatus,
        "BatteryCap": BatteryCap,
        "BatteryHistory": BatteryHistory,
        "Range": Range,
        "BluetoothOp": BluetoothOp,
        "BluetoothCon": BluetoothCon,
        "TheftState": TheftState,
        "SystemSOS": SystemSOS,
        "UserSOS": UserSOS,
      };

}
