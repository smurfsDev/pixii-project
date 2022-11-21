import "package:mobile/imports.dart";

class MainLayout extends StatelessWidget {
  Widget child;

  MainLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // begin: Alignment.centerLeft,
          // end: Alignment.centerRight,
          stops: const [0.1, 0.5, 1],
          colors: const [
            Color.fromRGBO(33, 39, 45, 1),
            Color.fromRGBO(44, 55, 91, 1),
            Color.fromRGBO(33, 39, 45, 1),
          ],
        ),
      ),
      child: child,
    );
  }
}