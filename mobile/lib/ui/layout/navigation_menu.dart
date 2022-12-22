// ignore_for_file: must_be_immutable

import 'package:mobile/imports.dart';
import 'package:mobile/main.dart';

class NavDrawerDemo extends StatelessWidget {
  User user;
  NavDrawerDemo(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: Color.fromRGBO(44, 55, 91, 1)),
      accountName: Text(user.name),
      accountEmail: Text(
        user.username,
      ),
      currentAccountPicture: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36.0),
          child: Image.asset(
            'assets/images/avatar.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
    final drawerItems = Container(
      child: ListView(
        children: [
          drawerHeader,
          ListTile(
            title: const Text(
              "Dashboard",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.dashboard_outlined,
              color: white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.person_outline,
              color: white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Invoices",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.feed_outlined,
              color: white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Wallet",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.wallet_outlined,
              color: white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Support",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.support_agent,
              color: white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.logout,
              color: white,
            ),
            onTap: () {
              AuthService().logout().then((value) => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))
                  });
            },
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
}
