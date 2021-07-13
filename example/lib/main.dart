import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fps_widget/fps_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPS Widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: FPSWidget(
          child: MyHomePage(title: 'FPS Widget Demo'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final r = Random();

class _MyHomePageState extends State<MyHomePage> {
  final s = Stopwatch();
  int throttledFramesCount = 0;

  void throttle() {
    s.start();

    int duration = r.nextInt(30) + 10;

    while (s.elapsedMilliseconds < duration) {}
    s.reset();
    s.stop();

    if (throttledFramesCount > 7) {
      throttledFramesCount = 0;
      return;
    }

    throttledFramesCount++;

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      throttle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text("Throttle FPS"),
          onPressed: throttle,
        ),
      ),
    );
  }
}
