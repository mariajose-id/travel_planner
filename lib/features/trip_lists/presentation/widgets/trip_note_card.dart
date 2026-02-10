import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/trip_lists/domain/entities/trip_note.dart';
import 'package:travel_planner/features/trip_lists/presentation/providers/trip_notes_notifier.dart';
import 'package:travel_planner/features/trip_lists/presentation/widgets/add_note_dialog.dart';
import 'package:travel_planner/shared/widgets/dialogs/app_confirmation_dialog.dart';

class TripNoteCard extends ConsumerWidget {
  final TripNote note;

  const TripNoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withValues(
              alpha: isDark ? 0.35 : 0.55,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: context.colorScheme.onSurface.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                showDialog(
                  context: context,
                  builder: (context) => AddNoteDialog(
                    tripId: note.tripId,
                    type: note.type,
                    note: note,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            note.type == NoteType.checklist
                                ? Icons.check_box_outlined
                                : Icons.text_fields,
                            size: 18,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            note.title,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: context.colorScheme.error.withValues(
                              alpha: 0.08,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              size: 18,
                              color: context.colorScheme.error.withValues(
                                alpha: 0.8,
                              ),
                            ),
                            onPressed: () => _confirmDelete(context, ref),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (note.type == NoteType.text)
                      Text(
                        note.content,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    else
                      _buildChecklistPreview(context),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.4,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(note.updatedAt, context),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurface.withValues(
                              alpha: 0.4,
                            ),
                            fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildChecklistPreview(BuildContext context) {
    if (note.items.isEmpty) {
      return Text(
        context.l10n.label_no_lists,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: context.colorScheme.onSurface.withValues(alpha: 0.4),
        ),
      );
    }

    final previewItems = note.items.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: previewItems.map((item) {
        return Row(
          children: [
            Icon(
              item.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              size: 16,
              color: item.isCompleted
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.text,
                style: context.textTheme.bodyMedium?.copyWith(
                  decoration: item.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  color: item.isCompleted
                      ? context.colorScheme.onSurface.withValues(alpha: 0.4)
                      : context.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  String _formatDate(DateTime date, BuildContext context) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    HapticFeedback.heavyImpact();
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: context.l10n.action_delete_note,
      message: context.l10n.dialog_delete_note_confirm,
      confirmText: context.l10n.action_delete,
      cancelText: context.l10n.action_cancel,
      isDangerous: true,
    );

    if (confirmed) {
      ref.read(tripNotesProvider(note.tripId).notifier).deleteNote(note.id);
    }
  }
}
