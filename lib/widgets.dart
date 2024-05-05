import 'package:flutter/material.dart';

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

appLogo(BuildContext context) {
  String logoPath = MediaQuery.of(context).platformBrightness == Brightness.light
      ? 'assets/images/OptiCompanion-Transparent - Light.png'
      : 'assets/images/OptiCompanion-Transparent - Dark.png';

  return Image.asset(logoPath, width: 90, height: 90);
}

icon(BuildContext context, String path) {
  String logoPath = path;

  MediaQuery.of(context).platformBrightness == Brightness.light
      ? logoPath = '${logoPath.split('.').first} - light.png'
      : logoPath = '${logoPath.split('.').first} - dark.png';

  return Image.asset(logoPath, width: 70, height: 70);
}
