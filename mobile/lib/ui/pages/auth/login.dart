// ignore_for_file: prefer_const_constructors

import 'package:mobile/imports.dart';
import 'package:mobile/ui/pages/home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String id = '/LoginPage';

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = "admin@email.com";
  String password = "Password123";
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
                            top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 80.0,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
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
                                    SizedBox(height: 60.0),
                                    MyInput(
                                      validation: validatePassword,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      hintText: 'Password',
                                      icon: Icons.lock,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      labelText: 'Enter your password',
                                    ),
                                    SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 40.0,
                                              height: 40.0,
                                              child: Checkbox(
                                                value: rememberMe,
                                                onChanged: (value) {
                                                  setState(() {
                                                    rememberMe = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Text(
                                              'Remember me',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(context, ForgotPassword.id);
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
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
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context, RegisterPage.id);
                                  },
                                  child: Text(
                                    ' Sign Up',
                                    style: TextStyle(
                                        fontSize: 18.0,
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
      final loginOK = await auth.login(email, password);
      setState(() {
        loading = false;
      });
      if (loginOK) {
        showAlert(context, 'Login Success', auth.user!.name);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        var message = "";
        if (auth.error == "USER_NOT_FOUND") {
          message = "Your email is not registered";
        } else if (auth.error == "INVALID_CREDENTIALS") {
          message = "Your password is incorrect";
        } else if (auth.error == "USER_DISABLED") {
          message = "Please verify your email";
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
