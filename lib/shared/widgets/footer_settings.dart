import 'package:flutter/material.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';

class FooterSettings extends StatefulWidget {
  const FooterSettings({super.key});

  @override
  State<FooterSettings> createState() => _FooterSettingsState();
}

class _FooterSettingsState extends State<FooterSettings> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _communityController = TextEditingController();
  final _ownerController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFooterData();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _communityController.dispose();
    _ownerController.dispose();
    super.dispose();
  }

  void _loadFooterData() {
    final localizations = AppLocalizations.of(context);
    setState(() {
      _addressController.text = localizations.footerAddress;
      _phoneController.text = localizations.footerPhoneNumber;
      _companyController.text = localizations.footerCompany;
      _communityController.text = localizations.footerCommunity;
      _ownerController.text = localizations.footerOwnerCreator;
    });
  }

  Future<void> _saveFooterData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate saving data (in real app, save to SharedPreferences or API)
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Footer information saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving footer information: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Footer Settings',
              style: context.headlineSmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter company address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an address';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _companyController,
              decoration: InputDecoration(
                labelText: 'Company',
                hintText: 'Enter company name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company name';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _communityController,
              decoration: InputDecoration(
                labelText: 'Community',
                hintText: 'Enter community name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a community name';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _ownerController,
              decoration: InputDecoration(
                labelText: 'Owner/Creator',
                hintText: 'Enter owner or creator name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter owner/creator name';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 32),
            
            AppButton(
              text: localizations.save,
              isLoading: _isLoading,
              onPressed: _saveFooterData,
            ),
          ],
        ),
      ),
    );
  }
}
