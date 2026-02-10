import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

/// Reusable text field widget with consistent styling.
/// Supports single-line and multiline inputs with proper icon alignment.
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int? maxLines;
  final bool? readOnly;
  final String? errorText;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.maxLines = 1,
    this.onTap,
    this.readOnly,
    this.errorText,
  });

  bool get _isMultiline => maxLines != null && maxLines! > 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          inputFormatters: inputFormatters,
          enabled: enabled,
          maxLines: maxLines,
          onTap: onTap,
          readOnly: readOnly ?? (onTap != null),
          style: context.textTheme.bodyLarge,
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hint,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            // Align icon to top for multiline, center for single line
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 8,
                top: _isMultiline ? 16 : 0,
              ),
              child: Align(
                alignment: _isMultiline
                    ? Alignment.topCenter
                    : Alignment.center,
                widthFactor: 1,
                heightFactor: _isMultiline ? null : 1,
                child: Icon(
                  prefixIcon,
                  color: context.colorScheme.primary,
                  size: 20,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 44,
              minHeight: _isMultiline ? 48 : 0,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled
                ? context.colorScheme.surface
                : context.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: _isMultiline ? 16 : 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.12),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
