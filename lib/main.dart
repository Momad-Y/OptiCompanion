import 'package:flutter/material.dart';
import './pages/pages.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black, fontFamily: 'Arial')),
        colorScheme: const ColorScheme.light(
            primary: Color(0xFFF0F0F0),
            secondary: Color(0xFF0F0F0F),
            tertiary: Color(0xFF090c9b),
            outline: Color(0xFF5AF705)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
