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
      debugShowCheckedModeBanner: false,
      theme: colorTheme(context),
      initialRoute: '/welcome1',
      routes: {
        '/home': (context) => const HomePage(),
        '/welcome1': (context) => const WelcomePage1(),
      },
    );
  }
}
