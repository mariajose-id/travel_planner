import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  text,
}

enum AppButtonIconPosition {
  left,
  right,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonVariant variant;
  final Widget? child;
  final IconData? icon;
  final AppButtonIconPosition iconPosition;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.variant = AppButtonVariant.primary,
    this.child,
    this.icon,
    this.iconPosition = AppButtonIconPosition.left,
  });

  
  factory AppButton.primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? child,
    IconData? icon,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.primary,
      child: child,
      icon: icon,
      iconPosition: iconPosition,
    );
  }

  factory AppButton.secondary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? child,
    IconData? icon,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.secondary,
      child: child,
      icon: icon,
      iconPosition: iconPosition,
    );
  }

  factory AppButton.outline({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? child,
    IconData? icon,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.outline,
      child: child,
      icon: icon,
      iconPosition: iconPosition,
    );
  }

  factory AppButton.text({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? child,
    IconData? icon,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.text,
      child: child,
      icon: icon,
      iconPosition: iconPosition,
    );
  }

  
  factory AppButton.google({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.outline,
      icon: Icons.g_mobiledata,
      iconPosition: iconPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ButtonStyle buttonStyle;
    Color textColor;

    switch (variant) {
      case AppButtonVariant.primary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        );
        textColor = theme.colorScheme.onPrimary;
        break;
      case AppButtonVariant.secondary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
          elevation: 0,
          shadowColor: theme.colorScheme.secondary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        );
        textColor = theme.colorScheme.onSecondary;
        break;
      case AppButtonVariant.outline:
        buttonStyle = OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          side: BorderSide(color: theme.colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        );
        textColor = theme.colorScheme.onSurface;
        break;
      case AppButtonVariant.text:
        buttonStyle = TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        );
        textColor = theme.colorScheme.primary;
        break;
    }

    
    Widget buildContent() {
      if (isLoading) {
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
        );
      }

      final textWidget = Text(
        text,
        style: context.buttonText.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      );

      
      if (icon == null) {
        return child ?? textWidget;
      }

      final iconWidget = Icon(
        icon,
        color: textColor,
        size: 20,
      );

      
      final widgets = iconPosition == AppButtonIconPosition.left
          ? [iconWidget, AppSpacing.horizontalGapSM, textWidget]
          : [textWidget, AppSpacing.horizontalGapSM, iconWidget];

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      );
    }

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: buttonStyle,
        child: buildContent(),
      ),
    );
  }
}
