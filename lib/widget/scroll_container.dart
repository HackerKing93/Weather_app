import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;

  const MyContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
    );
  }
}
