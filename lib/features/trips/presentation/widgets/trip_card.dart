import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_planner/features/trips/presentation/dtos/trip_dto.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

class TripCard extends StatelessWidget {
  final TripDto trip;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool showActions;

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: _buildCardDecoration(context),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap.call();
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _StatusIndicatorWidget(trip: trip),
                      const SizedBox(width: 14),
                      Expanded(child: _TripInfoWidget(trip: trip)),
                      if (showActions)
                        _TripActionsWidget(
                          status: trip.status,
                          statusColor: trip.statusColor,
                          onEdit: onEdit,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark 
          ? context.colorScheme.surface.withValues(alpha: 0.4)
          : Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: context.colorScheme.onSurface.withValues(alpha: 0.12),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}

class _StatusIndicatorWidget extends StatelessWidget {
  final TripDto trip;

  const _StatusIndicatorWidget({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: trip.statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(trip.statusIcon, color: trip.statusColor, size: 22),
    );
  }
}

class _TripInfoWidget extends StatelessWidget {
  final TripDto trip;

  const _TripInfoWidget({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trip.title,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              trip.displayDestination,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            Text(
              '•',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              trip.displayStartDate,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.primary.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trip.displayBudget,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TripActionsWidget extends StatelessWidget {
  final TripStatus status;
  final Color statusColor;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TripActionsWidget({
    required this.status,
    required this.statusColor,
    required this.onEdit,
    required this.onDelete,
  });

  void _handleDropdownChange(String? val) {
    if (val == 'edit') {
      onEdit();
    } else if (val == 'delete') {
      onDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _getStatusLabel(context, status),
            style: TextStyle(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AppDropdown<String>(
          value: null,
          icon: Icons.more_vert,
          items: [
            DropdownMenuItem(
              value: 'edit',
              child: Text(context.l10n.action_edit),
            ),
            DropdownMenuItem(
              value: 'delete',
              child: Text(context.l10n.action_delete),
            ),
          ],
          onChanged: _handleDropdownChange,
        ),
      ],
    );
  }

  String _getStatusLabel(BuildContext context, TripStatus status) {
    return switch (status) {
      TripStatus.planned => context.l10n.label_status_planned.toUpperCase(),
      TripStatus.upcoming => context.l10n.label_status_ongoing.toUpperCase(),
      TripStatus.completed => context.l10n.label_status_completed.toUpperCase(),
    };
  }
}
