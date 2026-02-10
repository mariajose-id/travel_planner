import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/shared/widgets/app_tab_bar.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

class TripsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const TripsAppBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        context.l10n.tab_your_trips,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.goNamed(AppRoutes.home),
      ),
      bottom: AppTabBar(
        controller: tabController,
        tabs: TripStatus.values.map((s) => _label(s, context.l10n)).toList(),
        currentIndex: tabController.index,
        onTap: (index) => tabController.animateTo(index),
      ),
    );
  }

  String _label(TripStatus s, AppLocalizations loc) {
    return switch (s) {
      TripStatus.planned => loc.label_status_planned,
      TripStatus.upcoming => loc.label_status_ongoing,
      TripStatus.completed => loc.label_status_completed,
    };
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
