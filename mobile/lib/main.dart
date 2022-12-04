import "package:mobile/imports.dart";

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
      const Duration(seconds: 3),
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
        },
        // onGenerateRoute: (settings) {
        //   if (settings.name == Register.id) {
        //     return MaterialPageRoute(
        //       builder: (context) => MainLayout(
        //         child: const Register(),
        //       ),
        //     );
        //   }else if (settings.name == Login.id) {
        //     return MaterialPageRoute(
        //       builder: (context) => MainLayout(
        //         child: const Login(),
        //       ),
        //     );
        //   }
        //   else {
        //     return MaterialPageRoute(
        //       builder: (context) => MainLayout(
        //         child: main,
        //       ),
        //     );
        //   }
        // },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: MainLayout(child: Login()),
      ),
    );
  }
  

}
