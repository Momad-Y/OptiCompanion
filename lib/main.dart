import 'package:flutter/material.dart';
import './pages/pages.dart';
import './themes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: colorTheme(context),
      home: const HomePage(),
    );
  }
}
