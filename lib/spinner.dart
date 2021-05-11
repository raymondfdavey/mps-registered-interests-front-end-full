import 'package:flutter/material.dart';
import 'dart:math' as math;

class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }
@override
dispose() {
  _controller.dispose(); // you need this
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image.asset("assets/images/gateToParliament.png", scale: 0.6, color: Colors.black,),
    );
  }
}
