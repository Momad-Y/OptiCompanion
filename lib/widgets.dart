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
