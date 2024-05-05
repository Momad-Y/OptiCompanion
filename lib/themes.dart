import 'package:flutter/material.dart';

ThemeData colorTheme(context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0F0F0F),
          secondary: Color(0xFFF0F0F0),
          tertiary: Color(0xFF0F13FF),
          outline: Color(0xFF5AF705),
          brightness: Brightness.light),
      useMaterial3: true,
    );
  } else {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFF0F0F0),
        secondary: Color(0xFF0F0F0F),
        tertiary: Color(0xFF090c9b),
        outline: Color(0xFF5AF705),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}

TextTheme textTheme(context) {
  return TextTheme(
      titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      labelLarge: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      displayLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'));
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
