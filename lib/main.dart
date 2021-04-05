import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    FlatButton button = FlatButton(
      child: Text("Button"),
      onPressed: () => print('here pressed'),
    );
    
    return Stack(
      children: <Widget>[
        DragBox(Offset(0.0, 50.0), '1', Colors.blueAccent),
        DragBox(Offset(200.0, 50.0), '2', Colors.orange),
        DragBox(Offset(300.0, 50.0), '3', Colors.lightGreen),
      ],
    );
  }
}


class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  void tap(Offset pos) {
    final result = HitTestResult();
    WidgetsBinding.instance.hitTest(result, pos);
    result.path.forEach((element) {
      element.target.handleEvent(
        PointerDownEvent(position: pos, kind: PointerDeviceKind.touch),
        element,
      );
      element.target.handleEvent(
        PointerUpEvent(position: pos, kind: PointerDeviceKind.touch),
        element,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          // data: widget.itemColor,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: widget.itemColor),
            width: 50.0,
            height: 50.0,
            // color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  // color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              print(offset);
              tap(offset);
              position = offset;
            });
          },
          feedback: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: widget.itemColor),
            width: 50.0,
            height: 50.0,
            // color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  // color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}


