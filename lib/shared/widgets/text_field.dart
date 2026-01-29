import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final int? maxLines;
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.maxLines = 1,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.titleSmall.copyWith(
            color: theme.colorScheme.onSurface,
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
          maxLines: maxLines,
          style: context.bodyMedium.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.5),
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: theme.colorScheme.primary,
                    size: 20,
                  )
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: theme.colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha:0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha:0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
