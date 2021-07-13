# fps_widget

[![lesnitsky.dev](https://lesnitsky.dev/shield.svg?hash=42252)](https://lesnitsky.dev?utm_source=fps_widget)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/fps_widget.svg?style=social)](https://github.com/lesnitsky/fps_widget)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

Simple FPS widget

![FPS Widget screenshot](https://lesnitsky-images.s3.eu-north-1.amazonaws.com/fps_widget_demo_screenshot.png)

## Installation

pubspec.yaml:

```yaml
dependencies:
  fps_widget: ^1.0.0
```

## Example

```dart
import 'package:flutter/material.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

```

## License

MIT
