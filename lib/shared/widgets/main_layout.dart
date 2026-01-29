import 'package:flutter/material.dart';
class MainLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  const MainLayout({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.appBar,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
