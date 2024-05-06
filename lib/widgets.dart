import 'package:flutter/material.dart';
import './themes.dart';

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
  String logoPath = MediaQuery.of(context).platformBrightness == Brightness.light
      ? 'assets/images/OptiCompanion-Transparent - Light.png'
      : 'assets/images/OptiCompanion-Transparent - Dark.png';

  return Image.asset(logoPath, width: width, height: height);
}

icon(BuildContext context, String path) {
  String logoPath = path;

  MediaQuery.of(context).platformBrightness == Brightness.light
      ? logoPath = '${logoPath.split('.').first} - light.png'
      : logoPath = '${logoPath.split('.').first} - dark.png';

  return Image.asset(logoPath, width: 70, height: 70);
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
