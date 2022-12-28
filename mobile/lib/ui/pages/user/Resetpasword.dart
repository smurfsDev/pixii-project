import 'package:mobile/imports.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart'; 


class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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
                // key: _formKey,
                child: Column(
              children: [
                MyInput(
                  validation: validatePassword,
                  onChanged: (value) {
                    setState(() {});
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
                    setState(() {});
                  },
                  hintText: 'Enter your new  password',
                  icon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: 'New password',
                ),
                const Divider(),
                MyInput(
                  validation: validatePassword,
                  onChanged: (value) {
                    setState(() {});
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
                        margin: const EdgeInsets.symmetric(horizontal: 70.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          onPressed: () {},
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
          ),
          const SizedBox(height: 24),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 19, 27, 54),
    );
  }
}
