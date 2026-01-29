import 'package:flutter/material.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/language_switch.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showThemeSwitch;
  final bool showLanguageSwitch;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showThemeSwitch = true,
    this.showLanguageSwitch = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        if (showLanguageSwitch) const LanguageSwitch(),
        if (showThemeSwitch) const ThemeSwitch(),
        ...?actions,
      ],
    );
  }
}
