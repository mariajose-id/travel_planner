import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/trip_lists/domain/entities/trip_note.dart';
import 'package:travel_planner/features/trip_lists/presentation/providers/trip_notes_notifier.dart';
import 'package:uuid/uuid.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';

class AddNoteDialog extends ConsumerStatefulWidget {
  final String tripId;
  final NoteType type;
  final TripNote? note;

  const AddNoteDialog({
    super.key,
    required this.tripId,
    required this.type,
    this.note,
  });

  @override
  ConsumerState<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends ConsumerState<AddNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late List<NoteItem> _items;
  final _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    _items = widget.note?.items.toList() ?? [];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                widget.type == NoteType.text
                                    ? Icons.note_alt_rounded
                                    : Icons.checklist_rtl_rounded,
                                color: context.colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                widget.type == NoteType.text
                                    ? context.l10n.label_add_note
                                    : context.l10n.label_checklists,
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
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: context.l10n.hint_note_title,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.l10n.error_required_field;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        if (widget.type == NoteType.text)
                          TextFormField(
                            controller: _contentController,
                            decoration: InputDecoration(
                              labelText: context.l10n.hint_note_content,
                            ),
                            maxLines: 5,
                          )
                        else
                          _buildChecklistEditor(context),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                text: context.l10n.action_cancel,
                                variant: AppButtonVariant.secondary,
                                onPressed: () => context.pop(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppButton(
                                text: context.l10n.action_save,
                                variant: AppButtonVariant.primary,
                                onPressed: () => _saveNote(),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildChecklistEditor(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  hintText: context.l10n.hint_checklist_item,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onSubmitted: (_) => _addItem(),
              ),
            ),
            IconButton(icon: const Icon(Icons.add), onPressed: _addItem),
          ],
        ),
        const SizedBox(height: 8),
        if (_items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No items yet'),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: item.isCompleted,
                onChanged: (val) {
                  setState(() {
                    _items[index] = item.copyWith(isCompleted: val);
                  });
                },
              ),
              title: Text(item.text),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () {
                  setState(() {
                    _items.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _addItem() {
    final text = _itemController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(NoteItem(id: const Uuid().v4(), text: text));
        _itemController.clear();
      });
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = TripNote(
        id: widget.note?.id ?? const Uuid().v4(),
        tripId: widget.tripId,
        title: _titleController.text,
        content: _contentController.text,
        items: _items,
        type: widget.type,
        updatedAt: DateTime.now(),
      );

      ref.read(tripNotesProvider(widget.tripId).notifier).saveNote(note);
      context.pop();
    }
  }
}
