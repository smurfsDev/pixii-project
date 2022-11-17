import 'package:flutter/material.dart';
import 'package:mobile/theme/colors.dart';
import 'package:mobile/ui/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: const Login());
  }
}
