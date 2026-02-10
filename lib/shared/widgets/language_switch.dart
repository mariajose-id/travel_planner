import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/providers/language_notifier.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/localization/language_config.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';

class LanguageSwitch extends ConsumerWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    final languageNotifier = ref.read(languageProvider.notifier);

    return AppDropdown<String>(
      value: locale.languageCode,
      borderRadius: 12,
      items: AppLanguageConfig.all.map((language) {
        return DropdownMenuItem<String>(
          value: language.code,
          child: Row(
            children: [
              Text(language.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(language.nativeName, style: context.labelLarge),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          languageNotifier.changeLanguage(newValue);
        }
      },
    );
  }
}
