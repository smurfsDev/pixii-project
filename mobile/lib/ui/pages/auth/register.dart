// ignore_for_file: prefer_const_constructors

import 'package:mobile/imports.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static String id = '/RegisterPage';

  @override
  State<Register> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = "admin@email.com";
  String password = "Password123";
  String username = "Admin";
  String confirmPassword = "Password123";
  String name = "Admin";
  String role = "Admin";
  bool rememberMe = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 60.0,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    MyInput(
                                      validation: validateName,
                                      onChanged: (value) {
                                        name = value;
                                      },
                                      hintText: 'Name',
                                      icon: Icons.person,
                                      keyboardType: TextInputType.name,
                                      labelText: 'Enter your name',
                                    ),
                                    SizedBox(height: 30.0,),
                                    MyInput(
                                      validation: validateEmail,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      hintText: 'Email',
                                      icon: Icons.email,
                                      keyboardType: TextInputType.emailAddress,
                                      labelText: 'Enter your email address',
                                    ),
                                    SizedBox(height: 30.0),
                                    MyInput(
                                      validation: validateUserName,
                                      onChanged: (value) {
                                        setState(() {
                                          username = value;
                                        });
                                      },
                                      hintText: 'Username',
                                      icon: Icons.person,
                                      keyboardType: TextInputType.name,
                                      labelText: 'Enter your username',
                                    ),
                                    SizedBox(height: 30.0),
                                    // MyInput(
                                    //   validation: validateRole,
                                    //   onChanged: (value) {
                                    //     setState(() {
                                    //       role = value;
                                    //     });
                                    //   },
                                    //   hintText: 'Role',
                                    //   icon: Icons.person,
                                    //   keyboardType: TextInputType.name,
                                    //   labelText: 'Enter your role',

                                    // ),
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Role',
                                        hintText: 'Role',
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0,
                                        ),
                                        hintStyle: const TextStyle(color: Colors.white),
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(width: 3, color: Colors.white),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(width: 3, color: Colors.blue),
                                        ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(width: 3, color: Colors.red),
                                        ),
                                      ),
                                      value: role,
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('User',style: const TextStyle(color: Colors.white),),
                                          value: 'User',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Admin',style: const TextStyle(color: Colors.white),),
                                          value: 'Admin',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          role = value.toString();
                                        });
                                      },
                                    ),
                                    SizedBox(height: 30.0),
                                    MyInput(
                                      validation: validatePassword,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      hintText: 'Password',
                                      icon: Icons.lock,
                                      keyboardType:TextInputType.visiblePassword,
                                      labelText: 'Enter your password',
                                    ),
                                    SizedBox(height: 30.0),
                                    MyInput(
                                      validation: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value != password) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          confirmPassword = value;
                                        });
                                      },
                                      hintText: 'Confirm Password',
                                      icon: Icons.lock,
                                      keyboardType: TextInputType.visiblePassword,
                                      labelText: 'Confirm your password',
                                    ),
                                    
                                  ],
                                )),
                            SizedBox(height: 40),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 70.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {
                                  sendForm(authService);
                                },
                                child: loading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                Text(
                                  'You already have an account?',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, Login.id);
                                  },
                                  child: Text(
                                    ' Login here',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  void sendForm(AuthService auth) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final registerOK = await auth.register(email, password, username, name, role, confirmPassword);
      setState(() {
        loading = false;
      });
      if (registerOK) {
        showAlert(context, 'register Success', auth.user!.name);
        Navigator.pushNamed(context, Login.id);
      } else {
        var message = "";
        if (auth.error == "email already exists") {
          message = "email already exists";
        } else if (auth.error == "username already exists") {
          message = "username already exists";
        } else {
          message = "An error has occurred";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
