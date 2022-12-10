import 'package:mobile/imports.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Notifications",
          style: TextStyle(
              color: Color.fromARGB(255, 252, 253, 255),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}