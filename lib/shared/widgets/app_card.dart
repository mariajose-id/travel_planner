import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: child,
      ),
    );
  }
}
