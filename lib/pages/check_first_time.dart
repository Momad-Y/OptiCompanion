import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:developer';

class CheckFirstTime extends StatefulWidget {
  const CheckFirstTime({super.key});

  @override
  State<CheckFirstTime> createState() => _CheckFirstTimeState();
}

class _CheckFirstTimeState extends State<CheckFirstTime> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');
    var duration = const Duration(seconds: 0);

    // Navigate to home page if not first time
    if (firstTime != null && !firstTime) {
      return Timer(duration, navigationPageHome);
    }

    // Navigate to welcome page if first time
    else {
      prefs.setBool('first_time', false);
      return Timer(duration, navigationPageWelcome);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void navigationPageWelcome() {
    Navigator.of(context).pushReplacementNamed('/welcome1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.primary,
    ));
  }
}
