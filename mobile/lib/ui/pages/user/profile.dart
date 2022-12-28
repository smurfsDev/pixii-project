import 'package:mobile/imports.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/Resetpasword.dart';
import 'package:mobile/ui/pages/user/scooter.dart';
import 'package:mobile/ui/pages/user/update_profile.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart';
import 'package:mobile/ui/pages/user/widget/profile_widget.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late UserPorfileService profileService;
  String email = "aazezafez";
  String imagePath = "faezdfa";
  String name = "ezafza";

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Widget build(BuildContext context) {
  profileService = Provider.of<UserPorfileService>(context);

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            image: imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 48),
          // buildInfo(user),

          menu(
              title: 'Your Scooter',
              icon: Icons.bike_scooter_sharp,
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scooter(),
                  ),
                );
              }),
          const Divider(),
          menu(
              title: 'Password',
              icon: Icons.lock,
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
              textcolor: Color.fromARGB(255, 255, 255, 255),
              onClick: () {}),
          const Divider(
            height: 80,
          ),
          // menu(title: 'Log out', icon: Icons.logout,textcolor: Color.fromARGB(184, 223, 39, 39), onClick: () {}),
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
    Future<User?> getuserinfo = UserPorfileService().getProfile();
    getuserinfo.then((value) {
      setState(() {
        email = value!.email;
        // imagePath = value.imagePath!;
        name = value.name;

        // UserPreferences().myUser = value;
      });
    });
  }
}

class menu extends StatelessWidget {
  const menu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
    this.endIcon = true,
    this.textcolor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(186, 70, 132, 255),
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
