import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:travel_planner/core/providers/language_notifier.dart';
import 'package:travel_planner/core/localization/language_config.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';
import 'package:travel_planner/shared/widgets/settings_tile.dart';
import 'package:travel_planner/shared/widgets/app_footer.dart';

class PreferencesTab extends ConsumerWidget {
  const PreferencesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageProvider);
    final languageNotifier = ref.read(languageProvider.notifier);
    final currentLanguage = AppLanguageConfig.all.firstWhere(
      (lang) => lang.code == currentLocale.languageCode,
      orElse: () => AppLanguageConfig.all.first,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        spacing: 24,
        children: [
          SectionCard(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.language_outlined,
                  title: context.l10n.label_language,
                  subtitle: currentLanguage.nativeName,
                  trailing: AppDropdown<AppLanguage>(
                    value: currentLanguage,
                    items: AppLanguageConfig.all.map((AppLanguage lang) {
                      return DropdownMenuItem<AppLanguage>(
                        value: lang,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(lang.emoji),
                            const SizedBox(width: 8),
                            Text(lang.nativeName),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (AppLanguage? newValue) async {
                      if (newValue != null) {
                        await languageNotifier.changeLanguage(newValue.code);
                      }
                    },
                  ),
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.palette_outlined,
                  title: context.l10n.label_theme,
                  subtitle: context.l10n.label_choose_theme,
                  trailing: const ThemeSwitch(),
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: context.l10n.label_notifications,
                  subtitle: context.l10n.label_manage_notifications,
                  showDivider: true,
                  onTap: () => openAppSettings(),
                ),
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: context.l10n.label_privacy,
                  subtitle: context.l10n.label_manage_data,
                  onTap: () => openAppSettings(),
                ),
              ],
            ),
          ),
          SectionCard(
            title: context.l10n.heading_developer_tools,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            backgroundColor: context.colorScheme.primary.withValues(
              alpha: 0.03,
            ),
            child: SettingsTile(
              icon: Icons.bug_report_outlined,
              title: context.l10n.label_wanderly_console,
              subtitle: context.l10n.label_wanderly_console_desc,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: AppLogger.talker,
                    theme: TalkerScreenTheme(
                      backgroundColor: context.colorScheme.surface,
                      textColor: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
