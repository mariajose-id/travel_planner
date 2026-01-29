import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  const NavigationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    assert(label.isNotEmpty, 'Label cannot be empty');
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(context),
          const SizedBox(height: 4),
          _buildLabel(context),
        ],
      ),
    );
  }
  Widget _buildIcon(BuildContext context) {
    final theme = Theme.of(context);
    
    if (isSelected) {
      return Container(
        padding: AppSpacing.paddingSM,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.8),
              theme.colorScheme.primary.withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: theme.colorScheme.onPrimary,
          size: 24,
        ),
      );
    }
    
    return Icon(
      icon,
      color: theme.colorScheme.onSurface.withValues(alpha:0.6),
      size: 24,
    );
  }
  Widget _buildLabel(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      label,
      style: context.labelSmall.copyWith(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.6),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
