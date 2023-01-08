import 'package:mobile/imports.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart';

class Scooter extends StatefulWidget {
  String scootername;
  Scooter(this.scootername, {super.key});

  @override
  State<Scooter> createState() => _Scooter();
}

class _Scooter extends State<Scooter> {
  String name = "";
  String? scootername = "";
  late UserPorfileService profileService;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  _Scooter();

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.scootername;
    });
    fetchscooter();
  }

  Widget build(
    BuildContext context,
  ) {
    profileService = Provider.of<UserPorfileService>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Align(
                child: Text(
                  'Change Your Scooter name by a click of button',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.center,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: name,
                      onChanged: (value) => {
                        setState(
                          () {
                            name = value;
                          },
                        )
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        labelText: 'Scooter Name',
                        prefixIcon: const Icon(
                          Icons.bike_scooter,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 70.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () {
                                updateScooterName(profileService);
                              },
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'update',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 24),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 19, 27, 54),
    );
  }

  void fetchscooter() async {
    Future getscootername = UserPorfileService().getProfile();
    getscootername.then((value) {
      setState(() {
        name = value['scootername'] ?? null;
      });
    });
  }

  void updateScooterName(UserPorfileService porfile) async {
    setState(() {
      loading = true;
    });
    Future updateScooter = porfile.updatescootername(name);
    updateScooter.then((value) {
      setState(() {
        loading = false;
      });
      if (value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Scooter Name Updated'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Scooter Name Not Updated'),
          ),
        );
      }
    });
  }
}
