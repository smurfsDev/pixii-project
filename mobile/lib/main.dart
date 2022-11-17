import 'package:flutter/material.dart';
import 'package:mobile/service/auth.dart';
import 'package:mobile/theme/colors.dart';
import 'package:mobile/ui/auth/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  //  Load Resources
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: const Login(),
      ),
    );
  }
}
