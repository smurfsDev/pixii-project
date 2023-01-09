import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/models/profile.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

class EditProfile extends StatefulWidget {
  String email;
  String name;
  String username;
  EditProfile(this.name, this.email, this.username, {super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String name = "";
  String username = "";
  String oldName = "";
  String oldEmail = "";
  bool loading = false;
  File? pickedImage;
  String? imagePath;
  late AuthService userService;
  @override
  void initState() {
    super.initState();
    setState(() {
      email = widget.email;
      name = widget.name;
      oldName = widget.name;
    });
    userService = AuthService();
    userService.loadSettings();
    User? user = userService.user;
    var storage = const FlutterSecureStorage();
    print(user?.image);

    fetchProfile();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var usr = await storage.read(key: "user");
      print(usr);
      var user = User.fromJson(jsonDecode(usr!));
      setState(() {
        imagePath = user.image;
      });
    });
  }

  Future<File> saveImagePermantly(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final permImage = File('${directory.path}/$name');
    return File(path).copy(permImage.path);
  }

  pickImage(ImageSource imageType, BuildContext context) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;

      final permImage = await saveImagePermantly(photo.path);
      final tempImage = File(photo.path);

      setState(() {
        pickedImage = permImage;
        fetchProfile();
      });

      var userProfilService = UserPorfileService();
      try {
        await userProfilService.updateProfileImage(permImage);
        final profile = await userProfilService.getProfile();
        var storage = const FlutterSecureStorage();
        var usr = await storage.read(key: "userprofile");
        var user = ProfileModel.fromJson(jsonDecode(usr!));
        setState(() {
          imagePath = user.image;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile image updated"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error updating profile image"),
          ),
        );
      }

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileService = Provider.of<UserPorfileService>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 0),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipOval(
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
                Positioned(
                  bottom: -6,
                  right: 2,
                  child: IconButton(
                    onPressed: () {
                      {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            pickImage(
                                                ImageSource.camera, context);
                                          },
                                          icon: const Icon(Icons.camera),
                                          label: const Text("CAMERA"),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            pickImage(
                                                ImageSource.gallery, context);
                                          },
                                          icon: const Icon(Icons.image),
                                          label: const Text("GALLERY"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text("@ ${username}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 2,
          ),
          Text(oldName,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 30,
          ),
          Form(
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
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      labelText: 'Full Name',
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
                  TextFormField(
                    initialValue: email,
                    onChanged: (value) => {
                      setState(
                        () {
                          email = value;
                        },
                      )
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid email';
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
                          margin: const EdgeInsets.symmetric(horizontal: 70.0),
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
                              sendProfile(context, profileService);
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
          const SizedBox(height: 24),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 19, 27, 54),
    );
  }

  void fetchProfile() async {
    var porfile = UserPorfileService();
    final profile = await porfile.getProfile();
    setState(() {
      name = profile['name'];
      email = profile['email'];
      oldName = profile['name'];
      username = profile['username'];
      imagePath = profile['image'] ?? null;
    });
  }

  void sendProfile(BuildContext context, UserPorfileService porfile) async {
    try {
      final profileupdated = await porfile.updateProfile(name, email);
      if (profileupdated == true) {
        setState(() {
          oldName = name;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Profile Updated',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error Updating Profile',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}

class image_widget extends StatelessWidget {
  const image_widget({
    Key? key,
    required this.fimage,
  }) : super(key: key);

  final File? fimage;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.file(
        fimage!,
        width: 160,
        height: 160,
        fit: BoxFit.cover,
      ),
    );
  }
}
