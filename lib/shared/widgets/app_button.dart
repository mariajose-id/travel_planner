import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_theme.dart';
import 'package:travel_planner/core/theme/app_typography.dart';

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  text,
  destructive,
  success,
}

enum AppButtonIconPosition { left, right }

enum AppButtonSize { small, medium, large }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonVariant variant;
  final Widget? child;
  final IconData? icon;
  final AppButtonIconPosition iconPosition;
  final AppButtonSize size;
  final double? width;
  final bool fullWidth;

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
    this.size = AppButtonSize.medium,
    this.width,
    this.fullWidth = false,
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
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.primary,
      icon: icon,
      iconPosition: iconPosition,
      size: size,
      fullWidth: fullWidth,
      child: child,
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
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.secondary,
      icon: icon,
      iconPosition: iconPosition,
      size: size,
      fullWidth: fullWidth,
      child: child,
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
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.outline,
      icon: icon,
      iconPosition: iconPosition,
      size: size,
      fullWidth: fullWidth,
      child: child,
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
    AppButtonSize size = AppButtonSize.medium,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.text,
      icon: icon,
      iconPosition: iconPosition,
      size: size,
      child: child,
    );
  }

  factory AppButton.destructive({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? child,
    IconData? icon,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.destructive,
      icon: icon,
      iconPosition: iconPosition,
      size: size,
      fullWidth: fullWidth,
      child: child,
    );
  }

  factory AppButton.success({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? child,
    IconData? icon,
    AppButtonIconPosition iconPosition = AppButtonIconPosition.left,
    AppButtonSize size = AppButtonSize.medium,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: AppButtonVariant.success,
      icon: icon,
      iconPosition: iconPosition,
      size: size,
      fullWidth: fullWidth,
      child: child,
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
      fullWidth: true,
    );
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  EdgeInsetsGeometry _getPadding() {
    return switch (widget.size) {
      AppButtonSize.small => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      AppButtonSize.medium => const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      AppButtonSize.large => const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 18,
      ),
    };
  }

  double _getHeight() {
    return switch (widget.size) {
      AppButtonSize.small => 40,
      AppButtonSize.medium => 52,
      AppButtonSize.large => 60,
    };
  }

  double _getFontSize() {
    return switch (widget.size) {
      AppButtonSize.small => 13,
      AppButtonSize.medium => 15,
      AppButtonSize.large => 17,
    };
  }

  double _getIconSize() {
    return switch (widget.size) {
      AppButtonSize.small => 16,
      AppButtonSize.medium => 20,
      AppButtonSize.large => 24,
    };
  }

  double _getBorderRadius() {
    return switch (widget.size) {
      AppButtonSize.small => 10,
      AppButtonSize.medium => 14,
      AppButtonSize.large => 18,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Variant-specific styling
    final (
      Color backgroundColor,
      Color foregroundColor,
      Color borderColor,
      List<BoxShadow>? shadows,
      Gradient? gradient,
    ) = _getVariantStyles(
      theme,
      isDark,
    );

    final isInteractive =
        !widget.isLoading && !widget.isDisabled && widget.onPressed != null;
    final opacity = widget.isDisabled ? 0.5 : 1.0;

    Widget buildContent() {
      if (widget.isLoading) {
        return SizedBox(
          width: _getIconSize(),
          height: _getIconSize(),
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
          ),
        );
      }

      final textWidget = Text(
        widget.text,
        textAlign: TextAlign.center,
        style: context.buttonText.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
          fontSize: _getFontSize(),
          letterSpacing: 0.3,
        ),
      );

      if (widget.icon == null) {
        return widget.child ?? textWidget;
      }

      final iconWidget = Icon(
        widget.icon,
        color: foregroundColor,
        size: _getIconSize(),
      );

      final widgets = widget.iconPosition == AppButtonIconPosition.left
          ? [
              iconWidget,
              SizedBox(width: widget.size == AppButtonSize.small ? 6 : 10),
              textWidget,
            ]
          : [
              textWidget,
              SizedBox(width: widget.size == AppButtonSize.small ? 6 : 10),
              iconWidget,
            ];

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      );
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: opacity,
            child: GestureDetector(
              onTapDown: isInteractive
                  ? (_) {
                      setState(() => _isPressed = true);
                      _animationController.forward();
                    }
                  : null,
              onTapUp: isInteractive
                  ? (_) {
                      setState(() => _isPressed = false);
                      _animationController.reverse();
                      widget.onPressed?.call();
                    }
                  : null,
              onTapCancel: isInteractive
                  ? () {
                      setState(() => _isPressed = false);
                      _animationController.reverse();
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                height: _getHeight(),
                width: widget.fullWidth ? double.infinity : widget.width,
                padding: _getPadding(),
                decoration: BoxDecoration(
                  color: gradient == null ? backgroundColor : null,
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                  border: borderColor != Colors.transparent
                      ? Border.all(
                          color: _isPressed
                              ? borderColor.withValues(alpha: 0.8)
                              : borderColor,
                          width: 1.5,
                        )
                      : null,
                  boxShadow: _isPressed
                      ? null
                      : shadows
                            ?.map(
                              (s) => BoxShadow(
                                color: s.color.withValues(
                                  alpha: s.color.a * 0.7,
                                ),
                                blurRadius: s.blurRadius * 0.8,
                                offset: s.offset * 0.8,
                                spreadRadius: s.spreadRadius * 0.8,
                              ),
                            )
                            .toList(),
                ),
                child: Center(child: buildContent()),
              ),
            ),
          ),
        );
      },
    );
  }

  (Color, Color, Color, List<BoxShadow>?, Gradient?) _getVariantStyles(
    ThemeData theme,
    bool isDark,
  ) {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return (
          Colors.transparent,
          Colors.white,
          Colors.transparent,
          [
            BoxShadow(
              color: AppTheme.secondary.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: AppTheme.secondary.withValues(alpha: 0.2),
              blurRadius: 40,
              offset: const Offset(0, 16),
              spreadRadius: -4,
            ),
          ],
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.secondary, AppTheme.secondaryDark],
          ),
        );

      case AppButtonVariant.secondary:
        return (
          AppTheme.primary,
          Colors.white,
          Colors.transparent,
          [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
          null,
        );

      case AppButtonVariant.outline:
        return (
          _isPressed
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          theme.colorScheme.primary,
          theme.colorScheme.primary.withValues(alpha: 0.5),
          null,
          null,
        );

      case AppButtonVariant.text:
        return (
          _isPressed
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          theme.colorScheme.primary,
          Colors.transparent,
          null,
          null,
        );

      case AppButtonVariant.destructive:
        // Danger gradient with warning glow
        const errorColor = Color(0xFFDC2626);
        const darkError = Color(0xFFB91C1C);
        return (
          Colors.transparent,
          Colors.white,
          Colors.transparent,
          [
            BoxShadow(
              color: errorColor.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 6),
              spreadRadius: -2,
            ),
          ],
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [errorColor, darkError],
          ),
        );

      case AppButtonVariant.success:
        const successColor = Color(0xFF16A34A);
        const darkSuccess = Color(0xFF15803D);
        return (
          Colors.transparent,
          Colors.white,
          Colors.transparent,
          [
            BoxShadow(
              color: successColor.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 6),
              spreadRadius: -2,
            ),
          ],
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [successColor, darkSuccess],
          ),
        );
    }
  }
}
