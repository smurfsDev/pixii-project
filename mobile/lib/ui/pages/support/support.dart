import 'package:mobile/imports.dart';

// ignore: must_be_immutable
class Support extends StatefulWidget {
  User user;
  Support(this.user, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Support> createState() => _Support();
}

class _Support extends State<Support> {
  String password = "";
  var index = 0;

  _Support();

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('Support'),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'Send reclamation',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Subject',
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Title',
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 400.0,
                    height: 200.0,
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Type here...',
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(224, 0, 119, 182)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  label: const Text(
                    "Send",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
                  ),
                  icon: const Icon(Icons.add,
                      color: Color.fromARGB(255, 255, 255, 255), size: 18),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 27, 54),
          drawer: NavDrawerDemo(widget.user),
        )));
  }

  hello() {
    print("object");
  }
}
