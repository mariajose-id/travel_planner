import 'package:flutter/material.dart';
class ErrorBoundary extends StatelessWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  final void Function(Object error, StackTrace? stackTrace)? onError;
  const ErrorBoundary({
    required this.child,
    this.errorBuilder,
    this.onError,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
class AppErrorWidget extends StatelessWidget {
  final Widget child;
  const AppErrorWidget({
    required this.child,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
