import "package:mobile/imports.dart";
import 'package:mobile/service/claims.dart';
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
  final authService = AuthService();
  @override
  initState() {
    super.initState();
    authService.loadSettings().then((value) => setState(
          () {
            main = authService.loggedIn
                ? Dashboard(authService.user!)
                : const Login();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ClaimsService()),
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
        home: MainLayout(child: main),
      ),
    );
  }
}
