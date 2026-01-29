import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color? color;

  const AppIcon({
    super.key,
    required this.iconData,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size,
      color: color ?? Theme.of(context).primaryColor,
    );
  }
}
