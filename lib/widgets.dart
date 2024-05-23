import 'package:flutter/material.dart';
import './themes.dart';
import '../settings.dart';
import '../tts.dart';

homeContainer(BuildContext context, Widget child) {
  return Container(
    width: 150,
    height: 150,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
    ),
    child: child,
  );
}

selectedHomeContainer(BuildContext context, Widget child) {
  return Container(
    width: 150,
    height: 150,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(width: 4, color: Theme.of(context).colorScheme.outline),
    ),
    child: child,
  );
}

appLogo(BuildContext context, double width, double height) {
  if (mainAppSettings.getTheme() == 1) {
    return Image.asset('assets/images/OptiCompanion-Transparent - Light.png', width: width, height: height);
  } else if (mainAppSettings.getTheme() == 2) {
    return Image.asset('assets/images/OptiCompanion-Transparent - Dark.png', width: width, height: height);
  } else {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return Image.asset('assets/images/OptiCompanion-Transparent - Dark.png', width: width, height: height);
    } else {
      return Image.asset('assets/images/OptiCompanion-Transparent - Light.png', width: width, height: height);
    }
  }
}

nextPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
        ),
        child: mainTts.getLanguage() == "English"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Next', style: textTheme(context).bodyMedium),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                  const SizedBox(width: 10),
                  Text('التالي', style: textTheme(context).bodyMedium),
                ],
              )),
  );
}

selectedNextPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.outline),
      ),
      child: mainTts.getLanguage() == "English"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Next', style: textTheme(context).bodyMedium),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                const SizedBox(width: 10),
                Text('التالي', style: textTheme(context).bodyMedium),
              ],
            ),
    ),
  );
}

previousPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: mainTts.getLanguage() == "English"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Previous', style: textTheme(context).bodyMedium),
                const SizedBox(width: 10),
                Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                const SizedBox(width: 10),
                Text('السابق', style: textTheme(context).bodyMedium),
              ],
            ),
    ),
  );
}

selectedPreviousPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.outline),
      ),
      child: mainTts.getLanguage() == "English"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Previous', style: textTheme(context).bodyMedium),
                const SizedBox(width: 10),
                Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                const SizedBox(width: 10),
                Text('السابق', style: textTheme(context).bodyMedium),
              ],
            ),
    ),
  );
}

homePageButton(BuildContext context) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, "/home"),
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: mainTts.getLanguage() == "English"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Home', style: textTheme(context).bodyMedium),
                const SizedBox(width: 10),
                Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                const SizedBox(width: 10),
                Text('الرئيسية', style: textTheme(context).bodyMedium),
              ],
            ),
    ),
  );
}

selectedHomePageButton(
  BuildContext context,
) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, "/home"),
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.outline),
      ),
      child: mainTts.getLanguage() == "English"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Home', style: textTheme(context).bodyMedium),
                const SizedBox(width: 10),
                Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary, size: 30),
                const SizedBox(width: 10),
                Text('الرئيسية', style: textTheme(context).bodyMedium),
              ],
            ),
    ),
  );
}

class BorderPainter extends CustomPainter {
  final BuildContext context;

  BorderPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;

    double cornerSide = sh * 0.15;

    Paint paint = Paint()
      ..color = Theme.of(context).colorScheme.secondary
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
