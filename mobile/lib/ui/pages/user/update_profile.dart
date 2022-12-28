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
  String name = "admin";
  String confirmemail = "admin@email.com";
  bool loading = false;
  _EditProfile(this.user);
  File? pickedImage;
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
      ),
    );
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

  Future<File> saveImagePermantly(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final permImage = File('${directory.path}/$name');
    return File(path).copy(permImage.path);
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
                    onPressed: imagePickerOption,
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
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton.icon(
          //       onPressed: () {},
          //       icon: const Icon(Icons.add_a_photo_sharp),
          //       label: const Text('UPLOAD IMAGE')),
          // ),

          // fimage != null
          //     ? image_widget(fimage: fimage)
          //     : Icon(
          //         Icons.person,
          //         size: 160,
          //       ),

          // SizedBox(height: 1),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.camera),
          //       color: Color.fromARGB(255, 94, 166, 225),
          //       iconSize: 30,
          //       onPressed: () => pickImage(ImageSource.camera),
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.image),
          //       color: Color.fromARGB(255, 94, 166, 225),
          //       iconSize: 30,
          //       onPressed: () => pickImage(ImageSource.gallery),
          //     ),
          //   ],
          // ),

          // ProfileWidget(
          //   image: user.imagePath,
          //   isEdit: true,
          //   onClicked: () => pickImage(),
          // ),
          // TextFieldWidget(
          //   label: 'Full Name',
          //   text: user.name,
          //   onChanged: (name) {},
          // ),
          const SizedBox(height: 8),
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
                  TextFormField(
                    initialValue: user.email,
                    onChanged: (value) => {
                      setState(
                        () {
                          confirmemail = value;
                        },
                      )
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      labelText: 'Confirm Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter email';
                      }
                      return null;
                    },
                  ),
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
    // print(user.name);
    // print(user.email);
    // print(confirmemail);
    if (user.email == confirmemail) {
      final profileupdated = await porfile.updateProfile(user.name, user.email);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email must match"),
        backgroundColor: Colors.red,
      ));
    }
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     loading = true;
    //   });
    // }
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
