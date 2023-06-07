import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentTimer = 2;
  int _currentTimerStart = 2;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _currentTimer = _currentTimerStart;
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentTimer == 1) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _currentTimer--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                minValue: 1,
                maxValue: 60,
                value: _currentTimerStart,
                onChanged: (value) => setState(
                  () {
                    _currentTimerStart = value;
                    _currentTimer = value;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 600,
                    ),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Text(
                      '$_currentTimer',
                      key: ValueKey<int>(_currentTimer),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: const Text("start"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
