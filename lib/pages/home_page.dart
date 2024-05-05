import 'package:flutter/material.dart';
import '../themes.dart';
import '../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  static const int _maxCounter = 2;
  static const int _minCounter = 0;
  static const int _velocityThreshold = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;

      if (_counter > _maxCounter) {
        _counter = 0;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;

      if (_counter < _minCounter) {
        _counter = _maxCounter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -_velocityThreshold) {
          _decrementCounter();
        } else if (details.primaryVelocity! > _velocityThreshold) {
          _incrementCounter();
        }
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/images/App Logo.png', width: 65, height: 65),
                const SizedBox(height: 20),
                Text(
                  'Home Screen',
                  style: textTheme(context).titleLarge!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            homeContainer(context, const Text("")),
                            homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
