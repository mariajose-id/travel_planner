import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/text_field.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/utils/app_date_utils.dart';
import 'package:travel_planner/core/error/error_handler.dart';

class TripForm extends StatefulWidget {
  final Trip? trip;
  final Function(Map<String, dynamic>) onSave;

  const TripForm({
    super.key,
    this.trip,
    required this.onSave,
  });

  @override
  State<TripForm> createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _destinationController = TextEditingController();
  final _budgetController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TripStatus _status = TripStatus.planned;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.trip != null) {
      _titleController.text = widget.trip!.title;
      _descriptionController.text = widget.trip!.description;
      _destinationController.text = widget.trip!.destination;
      _budgetController.text = widget.trip!.budget.toString();
      _startDate = widget.trip!.startDate;
      _endDate = widget.trip!.endDate;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.trip == null 
                      ? loc.addNewTrip 
                      : loc.editTrip,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                
                AppTextField(
                  controller: _titleController,
                  label: loc.tripTitle,
                  hint: loc.enterTripTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.pleaseEnterTripTitle;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                AppTextField(
                  controller: _descriptionController,
                  label: loc.description,
                  hint: loc.enterTripDescription,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.pleaseEnterDescription;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                AppTextField(
                  controller: _destinationController,
                  label: loc.destination,
                  hint: loc.enterDestination,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.pleaseEnterDestination;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, isStartDate: true),
                        child: AbsorbPointer(
                          child: AppTextField(
                            controller: TextEditingController(
                              text: _startDate != null 
                                  ? AppDateUtils.formatFormFieldDate(_startDate!)
                                  : '',
                            ),
                            label: loc.startDate,
                            hint: loc.selectStartDate,
                            validator: (value) {
                              if (_startDate == null) {
                                return loc.pleaseSelectStartDate;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, isStartDate: false),
                        child: AbsorbPointer(
                          child: AppTextField(
                            controller: TextEditingController(
                              text: _endDate != null 
                                  ? AppDateUtils.formatFormFieldDate(_endDate!)
                                  : '',
                            ),
                            label: loc.endDate,
                            hint: loc.selectEndDate,
                            validator: (value) {
                              if (_endDate == null) {
                                return loc.pleaseSelectEndDate;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                AppTextField(
                  controller: _budgetController,
                  label: loc.budget,
                  hint: loc.enterBudget,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.pleaseEnterBudget;
                    }
                    if (double.tryParse(value) == null) {
                      return loc.pleaseEnterValidNumber;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                DropdownButtonFormField<TripStatus>(
                  initialValue: _status,
                  decoration: InputDecoration(
                    labelText: loc.status,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                  ),
                  items: TripStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(_statusLabel(status, loc)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: loc.cancel,
                        variant: AppButtonVariant.outline,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButton(
                        text: widget.trip == null 
                            ? loc.addTrip 
                            : loc.updateTrip,
                        isLoading: _isLoading,
                        onPressed: _saveTrip,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusLabel(TripStatus status, AppLocalizations loc) {
    return switch (status) {
      TripStatus.planned => loc.planned,
      TripStatus.upcoming => loc.ongoing,
      TripStatus.completed => loc.completed,
    };
  }

  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate!.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
          if (_startDate != null && _startDate!.isAfter(_endDate!)) {
            _startDate = _endDate!.subtract(const Duration(days: 1));
          }
        }
      });
    }
  }

  Future<void> _saveTrip() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_startDate == null || _endDate == null) {
      ErrorHandler.showErrorToast(context, 'Please select both start and end dates');
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      ErrorHandler.showErrorToast(context, 'End date must be after start date');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final tripData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'destination': _destinationController.text,
        'startDate': _startDate!,
        'endDate': _endDate!,
        'budget': double.parse(_budgetController.text),
        'status': _status
      };
      await widget.onSave(tripData);
      
      if (mounted) {
        ErrorHandler.showSuccessToast(
          context, 
          widget.trip == null ? 'Trip created successfully!' : 'Trip updated successfully!'
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ErrorHandler.showErrorToast(context, 'Error: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
