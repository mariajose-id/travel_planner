import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/features/home/presentation/widgets/quick_action_card.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.8,
      children: [
        QuickActionCard(
          icon: Icons.public,
          title: context.l10n.heading_upcoming_trips,
          subtitle: '',
          color: const Color(0xFF42A5F5),
          onTap: () => context.goNamed(AppRoutes.trips),
        ),
        QuickActionCard(
          icon: Icons.add_circle_outline,
          title: context.l10n.action_add_trip,
          subtitle: '',
          color: const Color(0xFF66BB6A),
          onTap: () {
            final userId = ref.read(authNotifierProvider).value?.id;
            if (userId != null) {
              TripDialogs.showAddTripDialog(context, (trip) {
                ref.read(tripsProvider.notifier).addTrip(trip);
              }, userId);
            }
          },
        ),
        QuickActionCard(
          icon: Icons.currency_exchange_outlined,
          title: context.l10n.label_currency_converter,
          subtitle: '',
          color: const Color(0xFFFF7043), // Sunset Orange
          onTap: () {
            ResultHandler.showInfoToast(
              context,
              'Currency Converter Coming Soon!',
            );
          },
        ),
        QuickActionCard(
          icon: Icons.list_alt,
          title: context.l10n.nav_lists,
          subtitle: '',
          color: const Color(0xFFFFCA28),
          onTap: () => context.goNamed(AppRoutes.lists),
        ),
      ],
    );
  }
}
