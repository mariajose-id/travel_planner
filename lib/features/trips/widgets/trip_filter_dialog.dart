import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class TripFilterDialog extends StatefulWidget {
  final TripStatus? currentFilter;
  final Function(TripStatus?) onFilter;

  const TripFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilter,
  });

  @override
  State<TripFilterDialog> createState() => _TripFilterDialogState();
}

class _TripFilterDialogState extends State<TripFilterDialog> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  loc.filterByStatus,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              if (widget.currentFilter != null)
                TextButton(
                  onPressed: () {
                    widget.onFilter(null);
                    Navigator.pop(context);
                  },
                  child: Text(loc.clearFilters),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...TripStatus.values.map((status) => _buildFilterOption(
                context,
                status: status,
                isSelected: widget.currentFilter == status,
                onTap: () {
                  widget.onFilter(status);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }

  Widget _buildFilterOption(
    BuildContext context, {
    required TripStatus status,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final (icon, title) = switch (status) {
      TripStatus.planned => (Icons.flight, loc.planned),
      TripStatus.upcoming => (Icons.play_circle, loc.ongoing),
      TripStatus.completed => (Icons.check_circle, loc.completed),
    };

    return ListTile(
      leading: Icon(icon, color: isSelected ? theme.colorScheme.primary : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.colorScheme.primary : null,
        ),
      ),
      trailing: isSelected ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
      onTap: onTap,
    );
  }
}
