import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/ui/pages/user/profile.dart';

AppBar buildAppBar(BuildContext context) {
  // final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(user: null),
          ),
        );
            },
    ),
    iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
    backgroundColor: Color.fromARGB(0, 255, 255, 255),
    elevation: 0,
    // actions: [
    //   IconButton(
    //     icon: Icon(icon),
    //     onPressed: () {},
    //   )
    // ],
  );
}
