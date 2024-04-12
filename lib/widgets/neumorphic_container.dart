import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class NeumorphicContainer extends StatefulWidget {
  final Widget child;
  final double height;
  final double padding;
  final Color color;
  final Color upperShadowColor;
  final Color lowerShadowColor;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.height = 70,
    this.padding = 18,
    this.color = globals.backgroundTheme,
    this.upperShadowColor = const Color.fromRGBO(166, 146, 216, 1.0),
    this.lowerShadowColor = Colors.white,
  });

  @override
  State<NeumorphicContainer> createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
          height: widget.height,
          padding: EdgeInsets.all(widget.padding),
          decoration: BoxDecoration(
              boxShadow: _isPressed
                  ? null
              // [
              //         BoxShadow(
              //             spreadRadius: -2,
              //             blurRadius: 10,
              //             offset: const Offset(7, 7),
              //             color: widget.upperShadowColor),
              //         BoxShadow(
              //             spreadRadius: -10,
              //             blurRadius: 17,
              //             offset: const Offset(5, 5),
              //             color: widget.lowerShadowColor),
              //       ]
                  : [
                      BoxShadow(
                          spreadRadius: -10,
                          blurRadius: 17,
                          offset: const Offset(-5, -5),
                          color: widget.lowerShadowColor),
                      BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: const Offset(7, 7),
                          color: widget.upperShadowColor),
                    ],
              color: widget.color,
              borderRadius: BorderRadius.circular(20)),
          child: widget.child),
    );
  }
}
