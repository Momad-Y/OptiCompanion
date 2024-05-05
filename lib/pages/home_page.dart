import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  ScrollController controller = ScrollController();

  void _scrollPage() {
    if (_counter == 7 || _counter == 8) {
      // Scroll to the bottom of the page
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }

    if (_counter == 0 || _counter == 1 || _counter == 2) {
      // Scroll to the top of the page
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

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
          _scrollPage();
        } else if (details.primaryVelocity! > _velocityThreshold) {
          _incrementCounter();
          _scrollPage();
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
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 4,
                        color: _counter == 0 ? Theme.of(context).colorScheme.outline : const Color(0x00000000)),
                  ),
                  child: Text(
                    'Home Screen',
                    style: textTheme(context).titleLarge!,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 55),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 1
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomPaint(
                                              foregroundPainter: BorderPainter(context),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                  width: 65,
                                                  height: 65,
                                                  child: Text("A", style: textTheme(context).displayLarge!))),
                                          const SizedBox(height: 19),
                                          Text("OCR", style: textTheme(context).labelLarge!),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomPaint(
                                              foregroundPainter: BorderPainter(context),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                  width: 65,
                                                  height: 65,
                                                  child: Text("A", style: textTheme(context).displayLarge!))),
                                          const SizedBox(height: 19),
                                          Text("OCR", style: textTheme(context).labelLarge!),
                                        ])),
                            const SizedBox(width: 45),
                            _counter == 2
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomPaint(
                                              foregroundPainter: BorderPainter(context),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                  width: 65,
                                                  height: 65,
                                                  child: Icon(Icons.pedal_bike,
                                                      size: 40, color: Theme.of(context).colorScheme.secondary))),
                                          const SizedBox(height: 10),
                                          Text("Object Recognition",
                                              style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomPaint(
                                              foregroundPainter: BorderPainter(context),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 4),
                                                  width: 65,
                                                  height: 65,
                                                  child: Icon(Icons.pedal_bike,
                                                      size: 40, color: Theme.of(context).colorScheme.secondary))),
                                          const SizedBox(height: 10),
                                          Text("Object Recognition",
                                              style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                        ])),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 3
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.file_open_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 10),
                                          Text("Document Reader",
                                              style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                          const SizedBox(height: 5),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.file_open_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 10),
                                          Text("Document Reader",
                                              style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                          const SizedBox(height: 5),
                                        ])),
                            const SizedBox(width: 45),
                            _counter == 4
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.thumbs_up_down_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("Feedback",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.thumbs_up_down_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("Feedback",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ])),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 5
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.settings_applications_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("Settings",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.settings_applications_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("Settings",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ])),
                            const SizedBox(width: 45),
                            _counter == 6
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.help_outline_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("Help",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.help_outline_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("Help",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ])),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _counter == 7
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.mail_outline_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 10),
                                          Text("Get in Touch with Us",
                                              style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                          const SizedBox(height: 5),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.mail_outline_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 10),
                                          Text("Get in Touch with Us",
                                              style: textTheme(context).labelMedium!, textAlign: TextAlign.center),
                                          const SizedBox(height: 5),
                                        ])),
                            const SizedBox(width: 45),
                            _counter == 8
                                ? selectedHomeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.history_toggle_off_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("History",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ]))
                                : homeContainer(
                                    context,
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.history_toggle_off_rounded,
                                              size: 60, color: Theme.of(context).colorScheme.secondary),
                                          const SizedBox(height: 12),
                                          Text("History",
                                              style: textTheme(context).labelLarge!, textAlign: TextAlign.center),
                                          const SizedBox(height: 8),
                                        ])),
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
