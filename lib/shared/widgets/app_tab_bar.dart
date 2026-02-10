import 'package:flutter/material.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: context.colorScheme.onPrimary,
        unselectedLabelColor: context.colorScheme.onSurface.withValues(
          alpha: 0.6,
        ),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        tabs: tabs.map((tab) => Tab(height: 36, text: tab)).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
