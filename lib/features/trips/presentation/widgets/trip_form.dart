import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_form_provider.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/shared/widgets/forms/app_date_field.dart';
import 'package:travel_planner/shared/widgets/app_dropdown.dart';
import 'package:travel_planner/core/result/result_handler.dart';

class TripForm extends ConsumerStatefulWidget {
  final Trip? trip;
  final Function(Map<String, dynamic>) onSave;

  const TripForm({super.key, this.trip, required this.onSave});

  @override
  ConsumerState<TripForm> createState() => _TripFormState();
}

class _TripFormState extends ConsumerState<TripForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _destinationController = TextEditingController();
  final _budgetController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TripStatus _status = TripStatus.planned;

  @override
  void initState() {
    super.initState();
    if (widget.trip != null) {
      _titleController.text = widget.trip!.title;
      _descriptionController.text = widget.trip!.description;
      _destinationController.text = widget.trip!.destination.value;
      _budgetController.text = widget.trip!.budget.amountString;
      _startDate = widget.trip!.startDate.value;
      _endDate = widget.trip!.endDate.value;
      _status = widget.trip!.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _destinationController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _saveTrip() async {
    if (!_formKey.currentState!.validate()) return;

    final tripFormNotifier = ref.read(tripFormNotifierProvider.notifier);
    tripFormNotifier.setLoading(true);
    tripFormNotifier.clearError();

    const successCreate = 'Trip created successfully!';
    const successUpdate = 'Trip updated successfully!';

    try {
      final tripData = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'destination': _destinationController.text.trim(),
        'budget': _budgetController.text.trim(),
        'startDate': _startDate,
        'endDate': _endDate,
        'status': _status,
      };

      await widget.onSave(tripData);

      tripFormNotifier.setSuccessMessage(
        widget.trip == null ? successCreate : successUpdate,
      );

      if (mounted) {
        ResultHandler.showSuccessToast(
          context,
          widget.trip == null ? successCreate : successUpdate,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      tripFormNotifier.setError('Failed to save trip: $e');
      if (mounted) {
        ResultHandler.showErrorToast(context, 'Failed to save trip: $e');
      }
    } finally {
      tripFormNotifier.setLoading(false);
    }
  }

  Future<void> _pickDate(bool isStart) async {
    final initialDate = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());
    final firstDate = isStart ? DateTime(2000) : (_startDate ?? DateTime(2000));
    final lastDate = DateTime(2100);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripFormState = ref.watch(tripFormNotifierProvider);

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: context.colorScheme.onSurface.withValues(
                      alpha: 0.12,
                    ),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary.withValues(
                                  alpha: 0.1,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.trip == null
                                    ? Icons.map_rounded
                                    : Icons.edit_location_rounded,
                                color: context.colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                widget.trip == null
                                    ? context.l10n.heading_create_trip
                                    : context.l10n.heading_edit_trip,
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.8,
                                      color: context.colorScheme.onSurface,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        AppTextField(
                          controller: _titleController,
                          label: context.l10n.label_trip_title,
                          hint: context.l10n.hint_enter_trip_title,
                          prefixIcon: Icons.title,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return context.l10n.error_required_field;
                            }
                            if (val.length < 3) {
                              return 'Title must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _descriptionController,
                          label: context.l10n.label_description,
                          hint: context.l10n.hint_enter_description,
                          prefixIcon: Icons.description_outlined,
                          maxLines: 3,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return context.l10n.error_required_field;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _destinationController,
                          label: context.l10n.label_destination,
                          hint: context.l10n.hint_enter_destination,
                          prefixIcon: Icons.location_on_outlined,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return context.l10n.error_required_field;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _budgetController,
                          label: context.l10n.label_budget,
                          hint: context.l10n.hint_enter_budget,
                          prefixIcon: Icons.attach_money_outlined,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return context.l10n.error_required_field;
                            }
                            if (double.tryParse(val) == null) {
                              return 'Please enter a valid budget amount';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppDateField(
                          label: context.l10n.label_start_date,
                          date: _startDate,
                          onTap: () => _pickDate(true),
                          validator: (date) {
                            if (_startDate == null) {
                              return 'Please select a start date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AppDateField(
                          label: context.l10n.label_end_date,
                          date: _endDate,
                          onTap: () => _pickDate(false),
                          validator: (date) {
                            if (_endDate == null) {
                              return 'Please select an end date';
                            }
                            if (_startDate != null &&
                                _endDate!.isBefore(_startDate!)) {
                              return 'End date must be after start date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.label_status,
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppDropdown<TripStatus>(
                              value: _status,
                              items: TripStatus.values.map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(
                                    status.name[0].toUpperCase() +
                                        status.name.substring(1),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _status = value);
                                }
                              },
                              borderRadius: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                text: context.l10n.action_cancel,
                                onPressed: tripFormState.isLoading
                                    ? null
                                    : () => Navigator.pop(context),
                                variant: AppButtonVariant.secondary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppButton(
                                text: widget.trip == null
                                    ? context.l10n.action_create
                                    : context.l10n.action_save,
                                onPressed: tripFormState.isLoading
                                    ? null
                                    : _saveTrip,
                                isLoading: tripFormState.isLoading,
                                variant: AppButtonVariant.primary,
                              ),
                            ),
                          ],
                        ),
                        if (tripFormState.error != null) ...[
                          const SizedBox(height: 16),
                          _ErrorBanner(
                            error: tripFormState.error!,
                            onDismiss: () => ref
                                .read(tripFormNotifierProvider.notifier)
                                .clearError(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String error;
  final VoidCallback onDismiss;

  const _ErrorBanner({required this.error, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: context.colorScheme.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: onDismiss,
            color: context.colorScheme.error,
          ),
        ],
      ),
    );
  }
}
