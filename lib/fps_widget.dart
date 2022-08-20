import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

extension _FPS on Duration {
  double get fps => (1000 / inMilliseconds);
}

class FPSWidget extends StatefulWidget {
  final Widget child;
  final Alignment alignment;
  final bool show;

  const FPSWidget({
    Key? key,
    required this.child,
    this.show = true,
    this.alignment = Alignment.topRight,
  }) : super(key: key);

  @override
  _FPSWidgetState createState() => _FPSWidgetState();
}

class _FPSWidgetState extends State<FPSWidget> {
  Duration? prev;
  List<Duration> timings = [];
  double width = 150;
  double height = 100;
  late int framesToDisplay = width ~/ 5;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(update);
    super.initState();
  }

  update(Duration duration) {
    setState(() {
      if (prev != null) {
        this.timings.add(duration - prev!);
        if (this.timings.length > framesToDisplay) {
          this.timings =
              this.timings.sublist(this.timings.length - framesToDisplay - 1);
        }
      }

      prev = duration;
    });

    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback(update);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment,
      children: [
        widget.child,
        Visibility(
          visible: widget.show,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height,
              width: width + 17,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Color(0xaa000000),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (timings.isNotEmpty)
                    Text(
                      'FPS: ${timings.last.fps.toStringAsFixed(0)}',
                      style: TextStyle(color: Color(0xffffffff)),
                    ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...timings.map((timing) {
                            final p = (timing.fps / 60).clamp(0.0, 1.0);

                            return Padding(
                              padding: EdgeInsets.only(
                                right: 1.0,
                              ),
                              child: Container(
                                color: Color.lerp(
                                  Color(0xfff44336),
                                  Color(0xff4caf50),
                                  p,
                                ),
                                width: 4,
                                height: p * height,
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
