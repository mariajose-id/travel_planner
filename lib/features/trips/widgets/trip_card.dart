import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final statusColor = getStatusColor(trip.status);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    getStatusIcon(trip.status),
                    color: statusColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              trip.destination,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildInfoChip(
                            icon: Icons.calendar_today_outlined,
                            text: _formatDate(trip.startDate),
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            icon: Icons.attach_money,
                            text: '\$${trip.budget.toStringAsFixed(0)}',
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _statusLabel(trip.status, loc),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                      padding: EdgeInsets.zero,
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            onEdit();
                            break;
                          case 'delete':
                            onDelete();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18, color: theme.colorScheme.primary),
                              const SizedBox(width: 10),
                              Text(loc.editTrip, style: theme.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                              const SizedBox(width: 10),
                              Text(loc.delete, style: theme.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month;
    final day = date.day;
    return '$month/$day';
  }

  String _statusLabel(TripStatus status, AppLocalizations loc) {
    return switch (status) {
      TripStatus.planned => loc.planned,
      TripStatus.upcoming => loc.ongoing,
      TripStatus.completed => loc.completed,
    }.toUpperCase();
  }

  static Color getStatusColor(TripStatus status) {
    return switch (status) {
      TripStatus.planned => Colors.blue,
      TripStatus.upcoming => Colors.green,
      TripStatus.completed => Colors.orange,
    };
  }

  static IconData getStatusIcon(TripStatus status) {
    return switch (status) {
      TripStatus.planned => Icons.flight_takeoff,
      TripStatus.upcoming => Icons.flight,
      TripStatus.completed => Icons.check_circle,
    };
  }
}
