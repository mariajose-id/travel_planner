import 'package:flutter/material.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/utils/app_date_utils.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final String? hint;
  final DateTime? date;
  final VoidCallback onTap;
  final String? Function(DateTime?)? validator;

  const AppDateField({
    super.key,
    required this.label,
    this.hint,
    required this.date,
    required this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: date,
      validator: validator,
      builder: (FormFieldState<DateTime> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: TextEditingController(
                text: date != null
                    ? AppDateUtils.formatFormFieldDate(date!)
                    : '',
              ),
              label: label,
              hint: hint ?? context.l10n.action_select_date,
              prefixIcon: Icons.calendar_today,
              onTap: onTap,
              readOnly: true,
              errorText: state.errorText,
            ),
          ],
        );
      },
    );
  }
}
