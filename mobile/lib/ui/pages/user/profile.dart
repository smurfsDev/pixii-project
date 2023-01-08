import 'dart:convert';
import 'dart:io';

import 'package:mobile/imports.dart';
import 'package:mobile/main.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/Resetpasword.dart';
import 'package:mobile/ui/pages/user/scooter.dart';
import 'package:mobile/ui/pages/user/update_profile.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart';
import 'package:mobile/ui/pages/user/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  User? user;
  ProfilePage({this.user, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage(this.user);
}

class _ProfilePage extends State<ProfilePage> {
  User? user;
  late UserPorfileService profileService;
  late AuthService authService;
  String email = '';
  String? image;
  String name = "";
  String? scootername = "";
  String username = "";
  String? imagePath;
  File? pickedImage;
  _ProfilePage(this.user);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUser();
  }

  @override
  void didUpdateWidget(covariant ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchUser();
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService = AuthService();
      authService.loadSettings();
      User? ur = authService.user;
      setState(() {
        user = ur;
      });
    });
  }

  Widget build(BuildContext context) {
    profileService = Provider.of<UserPorfileService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
          },
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo, width: 0),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ProfileWidget(
            image: imagePath != null
                ? Environment.apiUrl + "/user-photos/" + imagePath!
                : 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfile(name, email, username),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 48),
          menu(
              title: 'Your Scooter',
              icon: Icons.bike_scooter_sharp,
              bcolor: Color.fromARGB(186, 70, 132, 255),
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scooter(scootername ?? ""),
                  ),
                );
              }),
          const Divider(),
          menu(
              title: 'Password',
              icon: Icons.lock,
              bcolor: Color.fromARGB(186, 70, 132, 255),
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Password(),
                  ),
                );
              }),
          const SizedBox(height: 20),
          menu(
              title: 'Information',
              icon: Icons.info_rounded,
              bcolor: Color.fromARGB(186, 70, 132, 255),
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {}),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 19, 27, 54),
      // bottomNavigationBar: bottomNav(),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            name,
            // ignore: prefer_const_constructors
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      );

  buildInfoItem({required IconData icon, required String text}) {
    final color = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void fetchUser() async {
    var porfileservice = UserPorfileService();
    final profile = await porfileservice.getProfile();
    var storage = const FlutterSecureStorage();
    var usr = await storage.read(key: "userprofile");
    var usrs = await storage.read(key: "user");
    print(usrs);
    print(usr);
    var user = ProfileModel.fromJson(jsonDecode(usr!));
    print(user);
    setState(() {
      name = user.name;
      email = user.email;
      imagePath = user.image ?? null;
      username = user.username;
      scootername = user.scootername ?? null;
    });
  }
}

class menu extends StatelessWidget {
  const menu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
    required this.bcolor,
    this.endIcon = true,
    this.textcolor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final bool endIcon;
  final Color? textcolor;
  final Color bcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: bcolor,
        borderRadius: BorderRadius.all(Radius.circular(29)),
      ),
      child: ListTile(
        onTap: onClick,
        leading: SizedBox(
          width: 30,
          height: 30,
          child: Icon(
            icon,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.apply(color: textcolor),
        ),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 18,
                ),
              )
            : null,
      ),
    );
  }
}
