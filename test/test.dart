import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 82, 70, 103)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      if (_counter > 2) {
        _counter = 0;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;

      if (_counter < 0) {
        _counter = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < -1) {
          _decrementCounter();
        } else if (details.primaryVelocity! > 1) {
          _incrementCounter();
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: _counter == 0 ? Colors.blueAccent : const Color.fromARGB(0, 0, 0, 0))),
                child: const Text(
                  'Hi',
                ),
              ),
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: _counter == 1 ? Colors.blueAccent : const Color.fromARGB(0, 0, 0, 0))),
                  child: const Text(
                    'Hello',
                  )),
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: _counter == 2 ? Colors.blueAccent : const Color.fromARGB(0, 0, 0, 0))),
                  child: const Text(
                    'bye',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
