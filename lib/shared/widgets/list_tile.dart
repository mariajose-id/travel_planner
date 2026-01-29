import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
class ListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final EdgeInsetsGeometry? contentPadding;
  const ListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.contentPadding,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: _buildListItem(context),
    );
  }
  Widget _buildListItem(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: contentPadding ?? AppSpacing.paddingMD,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              AppSpacing.horizontalGapMD,
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title!,
                  if (subtitle != null) ...[
                    AppSpacing.verticalGapSM,
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              AppSpacing.horizontalGapMD,
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
