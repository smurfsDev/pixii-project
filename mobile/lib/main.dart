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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: MainLayout(child: main),
      ),
    );
  }
}
