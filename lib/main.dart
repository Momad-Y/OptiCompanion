import 'package:flutter/material.dart';
import './pages/pages.dart';
import './themes.dart';
import './settings.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo: Check if it is the first time the app is being run

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: mainAppSettings.getTheme == 0
          ? ThemeMode.system
          : mainAppSettings.getTheme == 1
              ? ThemeMode.light
              : ThemeMode.dark,
      initialRoute: '/welcome1',
      routes: {
        '/home': (context) => const HomePage(),
        '/welcome1': (context) => const WelcomePage1(),
        '/welcome2': (context) => const WelcomePage2(),
        '/welcome_settings1': (context) => const WelcomeSettingsPage1(),
        '/welcome_settings2': (context) => const WelcomeSettingsPage2(),
      },
    );
  }
}
