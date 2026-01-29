import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
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
    final localizations = AppLocalizations.of(context);
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
                        style: context.titleSmall.copyWith(
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
                              style: context.bodySmall.copyWith(
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
                            text: _formatDate(trip.startDate, localizations),
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
                        trip.status.toUpperCase(),
                        style: context.labelSmall.copyWith(
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
                              Text(localizations.editTrip, style: context.bodyMedium),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                              const SizedBox(width: 10),
                              Text(localizations.delete, style: context.bodyMedium),
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

  String _formatDate(DateTime date, AppLocalizations localizations) {
    final month = date.month;
    final day = date.day;
    return '$month/$day';
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return Colors.blue;
      case 'ongoing':
        return Colors.green;
      case 'completed':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return Icons.flight_takeoff;
      case 'ongoing':
        return Icons.flight;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.trip_origin;
    }
  }

  static String getRelativeTime(DateTime startDate, DateTime endDate, String status) {
    final now = DateTime.now();
    final difference = startDate.difference(now);
    
    if (status.toLowerCase() == 'completed') {
      final daysSinceEnd = now.difference(endDate).inDays;
      if (daysSinceEnd > 30) {
        final months = (daysSinceEnd / 30).floor();
        return '$months month${months > 1 ? 's' : ''} ago';
      }
      return '$daysSinceEnd day${daysSinceEnd != 1 ? 's' : ''} ago';
    } else if (status.toLowerCase() == 'ongoing') {
      final daysSinceStart = now.difference(startDate).inDays;
      if (daysSinceStart > 30) {
        final months = (daysSinceStart / 30).floor();
        return '$months month${months > 1 ? 's' : ''} in';
      }
      return 'Day $daysSinceStart';
    } else {
      if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '$months month${months > 1 ? 's' : ''} left';
      }
      final daysLeft = difference.inDays;
      if (daysLeft == 0) return 'Today';
      if (daysLeft == 1) return 'Tomorrow';
      return '$daysLeft days left';
    }
  }
}
