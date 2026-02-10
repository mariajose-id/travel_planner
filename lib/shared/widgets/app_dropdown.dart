import 'package:flutter/material.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final Widget? prefixIcon;
  final IconData? icon;
  final double borderRadius;
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.prefixIcon,
    this.icon,
    this.borderRadius = 16,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.3,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          icon: Icon(
            icon ?? Icons.unfold_more_rounded,
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            size: 18,
          ),
          hint: label != null
              ? Text(
                  label!,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                )
              : null,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          dropdownColor: context.colorScheme.surface,
          menuMaxHeight: 350,
          borderRadius: BorderRadius.circular(16),
          elevation: 12,
          selectedItemBuilder: (context) {
            return items.map((item) {
              return Container(
                alignment: Alignment.centerLeft,
                child: DefaultTextStyle(
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                  child: item.child is Text
                      ? Text((item.child as Text).data!)
                      : item.child,
                ),
              );
            }).toList();
          },
          items: items,
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}
