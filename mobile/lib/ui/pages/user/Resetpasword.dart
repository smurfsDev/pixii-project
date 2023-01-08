import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/imports.dart';
import 'package:mobile/service/user_profile.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart';

class Password extends StatefulWidget {
  const Password({super.key});
  @override
  State<Password> createState() => _Password();
}

class _Password extends State<Password> {
  String Password = '';
  String ConfirmPassword = '';
  String OldPassword = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 48),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Align(
                // ignore: prefer_const_constructors
                child: Text(
                  'Change Your Password by a click of button',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                    MyInput(
                      validation: validatePassword,
                      onChanged: (value) {
                        setState(() {
                          OldPassword = value;
                        });
                      },
                      hintText: 'Enter your old password',
                      icon: Icons.password,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'Old password',
                    ),
                    const Divider(),
                    MyInput(
                      validation: validatePassword,
                      onChanged: (value) {
                        setState(() {
                          Password = value;
                        });
                      },
                      hintText: 'Enter your new  password',
                      icon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'New password',
                    ),
                    const Divider(),
                    MyInput(
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value != Password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          ConfirmPassword = value;
                        });
                      },
                      hintText: 'Enter your new password again',
                      icon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'Confirm  password',
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
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () {
                                changePassword();
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

  //change paswword
  void changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        var userProfile = UserPorfileService();
        await userProfile.changePassword(
            OldPassword, Password, ConfirmPassword);
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
          ),
        );
      } catch (e) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst("Exception: ", "")),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please check your input'),
        ),
      );
    }
  }
}
