import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/router/app_route_names.dart';
import 'package:travel_planner/core/providers/language_provider.dart';
import 'package:travel_planner/features/auth/services/auth_service.dart';
import 'package:travel_planner/core/error/error_handler.dart';
import 'package:travel_planner/shared/widgets/user_avatar.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/app_tab_bar.dart';
import 'package:travel_planner/shared/widgets/list_tile.dart' as list_tile_widget;
import 'package:travel_planner/shared/widgets/app_footer.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/localization/language_config.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
        title: Text(
          localizations.settings,
          style: context.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: theme.colorScheme.onSurface,
          size: 24,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: AppTabBar(
            controller: _tabController,
            currentIndex: _currentTab,
            tabs: [
              localizations.tab_profile,
              localizations.tab_preferences,
              localizations.tab_account,
            ],
            onTap: (index) => _tabController.animateTo(index),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(context, theme, localizations),
          _buildPreferencesTab(context, theme, localizations),
          _buildAccountTab(context, theme, localizations),
        ],
      ),
    );
  }
  Widget _buildProfileTab(
      BuildContext context, ThemeData theme, AppLocalizations localizations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SectionCard(
            child: Column(
              children: [
                const UserAvatar(
                  size: 80,
                  showStatus: true,
                ),
                const SizedBox(height: 16),
                Text(
                  localizations.profile,
                  style: context.titleLarge.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localizations.manageYourProfile,
                  style: context.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPreferencesTab(
      BuildContext context, ThemeData theme, AppLocalizations localizations) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              child: Column(
                children: [
                  list_tile_widget.ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.palette_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      localizations.theme,
                      style: context.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      localizations.chooseTheme,
                      style: context.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    trailing: const ThemeSwitch(),
                  ),
                  _buildDivider(context),
                  list_tile_widget.ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      localizations.notifications,
                      style: context.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      localizations.manageNotifications,
                      style: context.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  _buildDivider(context),
                  list_tile_widget.ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.privacy_tip_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      localizations.privacy,
                      style: context.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      localizations.managePrivacy,
                      style: context.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              child: _buildLanguageSelector(context, theme, localizations, languageProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context, 
    ThemeData theme, 
    AppLocalizations localizations,
    LanguageProvider languageProvider,
  ) {
    return list_tile_widget.ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.language_outlined,
          color: theme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        localizations.language,
        style: context.titleMedium.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        languageProvider.currentLanguage?.nativeName ?? 'English',
        style: context.bodySmall.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: DropdownButton<LanguageInfo>(
        value: languageProvider.currentLanguage ?? AppLanguages.all.first,
        underline: const SizedBox.shrink(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: theme.colorScheme.primary,
          size: 20,
        ),
        onChanged: (LanguageInfo? newValue) async {
          if (newValue != null) {
            await languageProvider.changeLanguage(newValue.code);
          }
        },
        items: AppLanguages.all.map((LanguageInfo lang) {
          return DropdownMenuItem<LanguageInfo>(
            value: lang,
            child: Row(
              children: [
                Text(lang.emoji),
                const SizedBox(width: 8),
                Text(lang.nativeName),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildAccountTab(
      BuildContext context, ThemeData theme, AppLocalizations localizations) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SectionCard(
                  child: list_tile_widget.ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      localizations.signOut,
                      style: context.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      localizations.signOutConfirmation,
                      style: context.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    onTap: () => _showSignOutDialog(context, localizations),
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  child: list_tile_widget.ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      localizations.deleteAccount,
                      style: context.titleMedium.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      localizations.deleteAccountWarning,
                      style: context.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    onTap: () => _showDeleteAccountDialog(context, localizations),
                  ),
                ),
              ],
            ),
          ),
        ),
        const AppFooter(),
      ],
    );
  }
  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 72,
      endIndent: 16,
      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
    );
  }
  void _showSignOutDialog(BuildContext context, AppLocalizations localizations) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.signOut),
        content: Text(localizations.signOutConfirmation),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              localizations.cancel,
              style: context.labelLarge.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await AuthService().signOut();
                if (context.mounted) {
                  context.goNamed(AppRouteNames.auth);
                }
              } catch (e) {
                if (context.mounted) {
                  ErrorHandler.showErrorToast(
                      context, localizations.failedToSignOut);
                }
              }
            },
            child: Text(
              localizations.signOut,
              style: const TextStyle(color: Color(0xFFE91E63)),
            ),
          ),
        ],
      ),
    );
  }
  void _showDeleteAccountDialog(BuildContext context, AppLocalizations localizations) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          localizations.deleteAccount,
          style: const TextStyle(color: Colors.red),
        ),
        content: Text(localizations.deleteAccountConfirmation),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              localizations.cancel,
              style: context.labelLarge.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await AuthService().deleteAccount();
                if (context.mounted) {
                  context.goNamed(AppRouteNames.auth);
                }
              } catch (e) {
                if (context.mounted) {
                  ErrorHandler.showErrorToast(
                      context, localizations.failedToDeleteAccount);
                }
              }
            },
            child: Text(
              localizations.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
