import "package:mobile/imports.dart";

class Settings extends StatefulWidget {

  const Settings({
    Key? key,
  }) : super(key: key);


  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Settings",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 253, 255),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

