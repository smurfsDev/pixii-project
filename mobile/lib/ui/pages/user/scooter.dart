import 'package:mobile/imports.dart';
import 'package:mobile/ui/pages/user/widget/appbar_widget.dart'; 

class Scooter extends StatefulWidget {
  const Scooter({super.key});

  @override
  State<Scooter> createState() => _ScooterState();
}

class _ScooterState extends State<Scooter> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
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
                // key: _formKey,
                child: Column(
              children: [
                MyInput(
                  validation: validateName,
                  onChanged: (value) {
                    setState(() {
                      // name = value;
                    });
                  },
                  hintText: 'Enter your Scooter name',
                  icon: Icons.person,
                  // text: user.name,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Scooter name',
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
