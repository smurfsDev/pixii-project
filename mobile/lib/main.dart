import "package:mobile/imports.dart";
import 'package:mobile/ui/pages/home/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget main = const Loading();
  @override
  initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(
        () {
          main = const Login();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        routes: {
          Register.id: (context) => MainLayout(
                child: const Register(),
              ),
          Login.id: (context) => MainLayout(
                child: const Login(),
              ),
          VerifyEmail.id: (context) => MainLayout(
                child: const VerifyEmail(),
              ),
          ResetPassword.id: (context) => MainLayout(
                child: const ResetPassword(),
              ),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: MainLayout(child: Login()),
      ),
    );
  }
  

}
