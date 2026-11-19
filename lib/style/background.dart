import 'package:material_ui/material_ui.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
  return Container(
    color: Colors.white,
    // decoration: const BoxDecoration(
    //   image: DecorationImage(
    //     image: AssetImage(ImagesPath.background),
    //     fit: BoxFit.fill,
    //   ),
    // ),
    child: child,
  );
}
}
