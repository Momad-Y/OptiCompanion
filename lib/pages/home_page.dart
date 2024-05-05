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
  static const int _maxCounter = 8;
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
                appLogo(context),
                Text(
                  'Home Screen',
                  style: textTheme(context).titleLarge!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 0
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            _counter == 1
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 2
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            _counter == 3
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 4
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            _counter == 5
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 6
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                            const SizedBox(width: 45),
                            _counter == 7
                                ? selectedHomeContainer(context, const Text(""))
                                : homeContainer(context, const Text("")),
                          ],
                        ),
                        const SizedBox(height: 70),
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
