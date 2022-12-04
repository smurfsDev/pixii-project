import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final _formKey = GlobalKey<FormState>();
  String emailadress = "";
  String userName = "";

  String password = "";
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: (() => Navigator.pop(context)),
              ),
            ],
            title: const Text("Sign Up "),
          ),
          body: Text("Hello world"),
        )));
  }
}
