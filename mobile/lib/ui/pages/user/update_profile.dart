import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/imports.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  User user;
  EditProfile(this.user, {super.key});

  @override
  State<EditProfile> createState() => _EditProfile(this.user);
}

class _EditProfile extends State<EditProfile> {
  User user;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String name = "";
  // String confirmemail = "";
  bool loading = false;
  _EditProfile(this.user);
  File? pickedImage;

  Future<File> saveImagePermantly(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final permImage = File('${directory.path}/$name');
    return File(path).copy(permImage.path);
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;

      final permImage = await saveImagePermantly(photo.path);
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = permImage;
      });

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
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
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
                    child: pickedImage != null
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
                                            pickImage(ImageSource.camera);
                                          },
                                          icon: const Icon(Icons.camera),
                                          label: const Text("CAMERA"),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            pickImage(ImageSource.gallery);
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
          Text("@ ${user.username}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 2,
          ),
          Text(user.name,
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
                    initialValue: user.name,
                    onChanged: (value) => {
                      setState(
                        () {
                          user.name = value;
                        },
                      )
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
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
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: user.email,
                    onChanged: (value) => {
                      setState(
                        () {
                          user.email = value;
                        },
                      )
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
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
                  SizedBox(height: 20.0),
                  // TextFormField(
                  //   initialValue: user.email,
                  //   onChanged: (value) => {
                  //     setState(
                  //       () {
                  //         confirmemail = value;
                  //       },
                  //     )
                  //   },
                  //   style: TextStyle(color: Colors.white),
                  //   decoration: InputDecoration(
                  //     labelStyle: TextStyle(color: Colors.white),
                  //     hintStyle: TextStyle(color: Colors.white),
                  //     fillColor: Colors.white,
                  //     labelText: 'Confirm Email',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please re-enter email';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 70.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            onPressed: () {
                              sendProfile(context, profileService);
                            },
                            child: loading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
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

  void sendProfile(BuildContext context, UserPorfileService porfile) async {
    final profileupdated = await porfile.updateProfile(user.name, user.email);
    // setState(() {
    //   loading = false;
    // });
    //  if (profileupdated) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Profile updated"),
    //     backgroundColor: Color.fromARGB(255, 177, 177, 177),
    // ));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Profile not updated"),
    //     backgroundColor: Color.fromARGB(255, 177, 177, 177),
    //   ));
    // }
  }
  // print(user.name);
  // print(user.email);
  // print(confirmemail);
  // if (user.email) {
  // final profileupdated = await porfile.updateProfile(name, usemail);

  // } else {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   content: Text("Email must match"),
  //   backgroundColor: Colors.red,
  // ));
  // }
  // if (_formKey.currentState!.validate()) {
  //   setState(() {
  //     loading = true;
  //   });
  // }
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
