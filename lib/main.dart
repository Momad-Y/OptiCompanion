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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: mainAppSettings.getTheme == 0
          ? ThemeMode.system
          : mainAppSettings.getTheme == 1
              ? ThemeMode.light
              : ThemeMode.dark,
      home: const CheckFirstTime(),
      routes: {
        '/home': (context) => const HomePage(),
        '/welcome1': (context) => const WelcomePage1(),
        '/welcome2': (context) => const WelcomePage2(),
        '/welcome_settings1': (context) => const WelcomeSettingsPage1(),
        '/welcome_settings2': (context) => const WelcomeSettingsPage2(),
        '/document_reader': (context) => const DocumentReaderPage(),
        '/settings1': (context) => const SettingsPage1(),
        '/settings2': (context) => const SettingsPage2(),
        '/get_in_touch': (context) => const GetInTouchPage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}
