// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:io';

import 'package:mobile/imports.dart';
import 'package:mobile/main.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/profile.dart';
import 'package:mobile/ui/pages/home/dashboard.dart';
import 'package:mobile/ui/pages/support/myClaims.dart';
import 'package:mobile/ui/pages/support/support.dart';

class NavDrawerDemo extends StatefulWidget {
  User user;
  NavDrawerDemo(this.user, {super.key});
  @override
  State<NavDrawerDemo> createState() => _NavDrawerDemoState();
}

class _NavDrawerDemoState extends State<NavDrawerDemo> {
  late User user = User(
      username: '', name: '', email: '', role: [], image: '', scootername: '');
  late UserPorfileService profileService;
  String? image;
  String email = '';
  String name = "";
  String scootername = "";
  String username = "";
  String? imagePath;
  File? pickedImage;
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: Color.fromRGBO(44, 55, 91, 1)),
      accountName: Text(name),
      accountEmail: Text(username),
      currentAccountPicture: SizedBox(
        width: 72,
        height: 100,
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36.0),
            child: imagePath != null
                ? Image.network(
                    Environment.apiUrl + "/user-photos/" + imagePath!,
                    width: 128,
                    height: 128,
                    fit: BoxFit.cover,
                  )
                : pickedImage != null
                    ? Image.file(
                        pickedImage!,
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      ),
          ),
        ),
      ),
    );
    final drawerItems = Container(
      child: ListView(
        children: [
          drawerHeader,
          menu(
              bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'Dashboard',
              icon: Icons.dashboard_outlined,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard(user)));
              }),
          Divider(),
          menu(
              bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'Profile',
              icon: Icons.person_outline,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(user:user)));
              }),
              
          Divider(),
              menu(
              bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'Support',
              icon: Icons.support_agent,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Support(user)));
              }),
              Divider(),
              menu(
              bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'My claims',
              icon: Icons.support_agent,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyClaims(user)));
              }),
          Divider(height: 490),
          menu(
              bcolor: Color.fromARGB(185, 252, 18, 18),
              title: 'Logout',
              icon: Icons.contact_support_rounded,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                AuthService().logout().then((value) => {
                    Navigator.of(context).popUntil((route) => route.isFirst),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  });
              }),
          Divider(),
          Center(
            child: Text(
              "Version 1.0.0",
            )>>>>>>> main
          ),
        ],
      ),
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.1, 0.5, 1],
          colors: [
            Color.fromRGBO(33, 39, 45, 1),
            Color.fromRGBO(44, 55, 91, 1),
            Color.fromRGBO(33, 39, 45, 1),
          ],
        ),
      ),
      child: Drawer(
        child: drawerItems,
        backgroundColor: Color.fromRGBO(44, 55, 91, 1),
      ),
    );
  }

  void fetchUser() async {
    var porfile = UserPorfileService();
    final profile = await porfile.getProfile();
    setState(() {
      name = profile['name'];
      username = profile['username'];
      imagePath = profile['image'] ?? null;
    });
  }
}
