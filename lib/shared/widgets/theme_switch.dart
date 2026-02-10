import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/providers/theme_notifier.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final currentValue = themeMode.name;

    return AppDropdown<String>(
      value: currentValue,
      borderRadius: 12,
      onChanged: (String? newValue) {
        if (newValue != null) {
          final mode = ThemeMode.values.firstWhere((e) => e.name == newValue);
          themeNotifier.setThemeMode(mode);
        }
      },
      items: [
        DropdownMenuItem<String>(
          value: 'light',
          child: Row(
            children: [
              const Icon(
                Icons.light_mode_outlined,
                size: 20,
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.label_theme_light,
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: 'dark',
          child: Row(
            children: [
              const Icon(
                Icons.dark_mode_outlined,
                size: 20,
                color: Color(0xFFD4AF37),
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.label_theme_dark,
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
        ),
        DropdownMenuItem<String>(
          value: 'system',
          child: Row(
            children: [
              const Icon(
                Icons.brightness_auto_outlined,
                size: 20,
                color: Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.label_theme_system,
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
