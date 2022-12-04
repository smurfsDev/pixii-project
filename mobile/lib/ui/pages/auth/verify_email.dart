// ignore_for_file: prefer_const_constructors

import 'package:mobile/imports.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  static String id = '/VerifyEmailPage';

  @override
  State<VerifyEmail> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();
  String email = "admin@email.com";
  String Code = "Code123";
  bool rememberMe = false;
  bool loading = false;
  int _counter = 0;
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
                              'Verify your email address',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              'We mailed you a eigh-digit code to your  “email” Enter the code and your email below to confirm your account',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  height: 2,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 40.0,
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
                                      hintText: 'Enter your email address',
                                      icon: Icons.email,
                                      keyboardType: TextInputType.emailAddress,
                                      labelText: 'Email',
                                    ),
                                    SizedBox(height: 20.0),
                                    MyInput(
                                      validation: (val) {
                                        if (val!.length != 8) {
                                          return 'Code must be 8 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          Code = value;
                                        });
                                      },
                                      hintText: 'Enter your code',
                                      icon: Icons.lock,
                                      keyboardType: TextInputType.text,
                                      labelText: 'Code',
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                )),
                            SizedBox(height: 40),
                            Container(
                              // margin: EdgeInsets.symmetric(horizontal: 30.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
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
                                        'Verify',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                            SizedBox(height: 20.0),
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
      final VerifyEmailOK = await auth.verifyEmail(email, Code);
      setState(() {
        loading = false;
      });
      if (VerifyEmailOK) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email verified'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, Login.id);
      } else {
        var message = "";
        message =
            auth.verifyError == '' ? 'Verify Email Failed' : auth.verifyError;
        if (auth.verifyError == 'Wrong verification code') {
          setState(() {
            _counter++;
          });
          if (_counter > 3) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Did not receive the code?'),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Resend',
                onPressed: () async {
                  try {
                    var scal =
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Sending code...'),
                      backgroundColor: Colors.blue,
                    ));
                    await auth.resendVerificationToken(email);
                    scal.close();
                    scal = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Code sent'),
                      backgroundColor: Colors.green,
                    ));
                    Future.delayed(Duration(seconds: 2), () {
                      scal.close();
                    });

                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Code not sent'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
              ),
            ));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
          }
        } else {
          var snack = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
          if (message == 'User already verified') {
            Future.delayed(Duration(seconds: 2), () {
              snack.close();
              Navigator.pushNamed(context, Login.id);
            });
          }
        }
      }
    }
  }
}
