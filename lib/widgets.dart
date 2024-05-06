import 'package:flutter/material.dart';
import './themes.dart';
import '../settings.dart';

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
  if (AppSettings(context).getTheme == 1) {
    return Image.asset('assets/images/OptiCompanion-Transparent - Light.png', width: width, height: height);
  } else if (AppSettings(context).getTheme == 2) {
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
      width: 220,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Next', style: textTheme(context).labelLarge),
          const SizedBox(width: 10),
          Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.secondary, size: 35),
        ],
      ),
    ),
  );
}

selectedNextPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 220,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(width: 10),
          Text('Next', style: textTheme(context).labelLarge),
          const SizedBox(width: 10),
          Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.secondary, size: 35),
        ],
      ),
    ),
  );
}

previousPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 220,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary, size: 35),
          const SizedBox(width: 10),
          Text('Previous', style: textTheme(context).labelLarge),
        ],
      ),
    ),
  );
}

selectedPreviousPageButton(BuildContext context, String route) {
  return GestureDetector(
    onLongPress: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 220,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 4, color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.secondary, size: 35),
          const SizedBox(width: 10),
          Text('Previous', style: textTheme(context).labelLarge),
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
