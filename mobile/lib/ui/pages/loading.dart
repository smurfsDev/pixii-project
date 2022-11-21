import "package:mobile/imports.dart";

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  String loading = "in";
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        controller.value < 0.5 ? loading = "in" : loading = "out";
          return Opacity(
            opacity: loading == "out" ? controller.value : 1 - controller.value,
            child: child,
          );
      },
      child: const Center(
        child: Image(
          image: AssetImage("assets/images/logo.png"),
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
