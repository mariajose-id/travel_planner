import 'package:flutter/material.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

enum GradientDirection { topToBottom, bottomToTop, diagonal }

class AppBackgroundGradient extends StatelessWidget {
  final GradientDirection direction;
  final double? height;

  const AppBackgroundGradient({
    super.key,
    this.direction = GradientDirection.topToBottom,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: _getBegin(),
          end: _getEnd(),
          colors: _getColors(context, isLight),
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
    );
  }

  Alignment _getBegin() {
    return switch (direction) {
      GradientDirection.topToBottom => Alignment.topCenter,
      GradientDirection.bottomToTop => Alignment.bottomCenter,
      GradientDirection.diagonal => Alignment.topLeft,
    };
  }

  Alignment _getEnd() {
    return switch (direction) {
      GradientDirection.topToBottom => Alignment.bottomCenter,
      GradientDirection.bottomToTop => Alignment.topCenter,
      GradientDirection.diagonal => Alignment.bottomRight,
    };
  }

  List<Color> _getColors(BuildContext context, bool isLight) {
    final surface = context.colorScheme.surface;

    if (isLight) {
      return [const Color(0xFFFFF9E6), const Color(0xFFFFFDF5), surface];
    } else {
      return [
        const Color(0xFF2C2410).withValues(alpha: 0.3),
        context.colorScheme.surface,
        surface,
      ];
    }
  }
}
