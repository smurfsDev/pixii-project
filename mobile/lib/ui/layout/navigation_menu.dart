// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:io';

import 'package:mobile/imports.dart';
import 'package:mobile/main.dart';
import 'package:mobile/ui/pages/user/profile.dart';

class NavDrawerDemo extends StatelessWidget {
  User user;
  NavDrawerDemo(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    File? pickedImage;
    String? imagePath;
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: Color.fromRGBO(44, 55, 91, 1)),
      accountName: Text(user.name),
      accountEmail: Text(
        user.username,
      ),
      currentAccountPicture: SizedBox(
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
                Navigator.pop(context);
              }),
          Divider(),
          menu(
              bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'Profile',
              icon: Icons.person_outline,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(user)));
              }),
          Divider(),
          menu(
             bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'Inovices',
              icon: Icons.receipt_long_outlined,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                // Navigator.pop(context);
              }),
          Divider(),
          menu(
             bcolor: Color.fromARGB(186, 70, 132, 255),
              title: 'Wallet',
              icon: Icons.account_balance_wallet_outlined,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                // Navigator.pop(context);
              }),
          Divider( height: 500),
          menu(
               bcolor: Color.fromARGB(185, 252, 18, 18),
              title: 'Logout',
              icon: Icons.logout,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                AuthService().logout().then((value) => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  });
              }),
          // ListTile(
          //   title: const Text(
          //     "Dashboard",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   leading: const Icon(
          //     Icons.dashboard_outlined,
          //     color: white,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   title: const Text(
          //     "Profile",
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: const Icon(
          //     Icons.person_outline,
          //     color: white,
          //   ),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ProfilePage(user)));
          //   },
          // ),
          // ListTile(
          //   title: const Text(
          //     "Invoices",
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: const Icon(
          //     Icons.feed_outlined,
          //     color: white,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   title: const Text(
          //     "Wallet",
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: const Icon(
          //     Icons.wallet_outlined,
          //     color: white,
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   title: const Text(
          //     "Logout",
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: const Icon(
          //     Icons.logout,
          //     color: white,
          //   ),
          //   onTap: () {
          //     AuthService().logout().then((value) => {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => MyApp()))
          //         });
          //   },
          // ),
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
}
