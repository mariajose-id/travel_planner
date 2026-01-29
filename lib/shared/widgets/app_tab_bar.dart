import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  final int currentIndex;
  final List<String> tabs;
  final Function(int) onTap;
  final TabController? controller;

  const AppTabBar({
    super.key,
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      onTap: onTap,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      indicatorColor: Theme.of(context).primaryColor,
      labelColor: Theme.of(context).colorScheme.onSurface,
    );
  }
}
