import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/language_switch.dart';
class AuthLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showThemeLanguageSwitches;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  const AuthLayout({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.showThemeLanguageSwitches = true,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.appBar,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar ?? (title != null ? _buildAppBar(context) : null),
      body: SafeArea(
        child: Column(
          children: [
            if (showThemeLanguageSwitches) _buildHeader(context),
            Expanded(child: body),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: context.titleLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      actions: actions,
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
  Widget _buildHeader(BuildContext context) {
    return const Padding(
      padding: AppSpacing.paddingMD,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ThemeSwitch(),
          AppSpacing.horizontalGapSM,
          LanguageSwitch(),
        ],
      ),
    );
  }
}
