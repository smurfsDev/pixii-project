
import 'package:mobile/imports.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  static String id = '/ResetPasswordPage';

  @override
  State<ResetPassword> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String email = "admin@email.com";
  String Code = "Code123";
  bool loading = false;
  int _counter = 0;
  bool isVisibal = false;
  
  late String password;
  late String confirmPassword;
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
                  margin: const EdgeInsets.all(20),
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
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 60.0, bottom: 20.0, left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Reset your password',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Visibility(
                              visible: !isVisibal,
                              child:const Text(
                                'Write down your email to claim your token',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    height: 2,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Visibility(
                              visible: isVisibal,
                              child:const Text(
                                'We mailed you an eight-digit code to your email Enter the code and the new password below to reset your password account.',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    height: 2,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: !isVisibal,
                                      child: MyInput(
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
                                    ),
                                    const SizedBox(height: 20.0),
                                    Visibility(
                                      visible: isVisibal,
                                      child: Column(
                                        children: [
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
                                          const SizedBox(height: 20.0),
                                          MyInput(
                                            validation: validatePassword,
                                            onChanged: (value) {
                                              setState(() {
                                                password = value;
                                              });
                                            },
                                            hintText: 'Enter your password',
                                            icon: Icons.lock,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            labelText: 'Password',
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
                                      hintText: 'Confirm your password',
                                      icon: Icons.lock,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      labelText: 'Confirm Password',
                                    ),
                                        ],
                                      )
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                )),
                            const SizedBox(height: 40),
                            
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Visibility(
                                visible: !isVisibal,
                                child : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      ),
                                ),
                                onPressed: () {
                                  ForgotPassword(authService);
                                },
                                child: loading
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : const Text(
                                  'Request code',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      // add padding 5
                                      ),
                                      
                                ),
                              ),),),
                                Visibility(
                                visible: isVisibal,
                                child : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      ),
                                ),
                                onPressed: () {
                                  ResetPassword(authService);
                                },
                                child: loading
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : const Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white),
                                ),
                              ),),
                              ]),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                  ),
                );
        },
      ),
    );
  }
  void ForgotPassword(AuthService auth) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final forgot_password = await auth.ForgotPassword(email);
      if (forgot_password) {
        setState(() {
          isVisibal = true;
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        var message = "";
        message =
            auth.verifyError == '' ? 'Verify Email Failed' : auth.verifyError;
        if (auth.verifyError == 'Wrong verification code') {
          setState(() {
            _counter++;
          });
          if (_counter > 3) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Too many attempts'),
              backgroundColor: Colors.red,
            ));
            Navigator.pushNamed(context, Login.id);
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
  void ResetPassword(AuthService auth) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final reset_password = await auth.ResetPassword(email, Code, password);
      print(email);
      print(Code);
      print(password);
      if (reset_password) {
        Navigator.pushNamed(context, Login.id);
      } else {
        setState(() {
          loading = false;
        });
        var message = "";

        message =
            auth.verifyError == '' ? 'Verify Email Failed' : auth.verifyError;
        if (auth.verifyError == 'Wrong verification code') {
          setState(() {
            _counter++;
          });
          if (_counter > 3) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Too many attempts'),
              backgroundColor: Colors.red,
            ));
            Navigator.pushNamed(context, Login.id);
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}