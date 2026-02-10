import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/trip_lists/presentation/providers/trip_notes_notifier.dart';
import 'package:travel_planner/features/trip_lists/domain/entities/trip_note.dart';
import 'package:travel_planner/features/trip_lists/presentation/widgets/add_note_dialog.dart';
import 'package:travel_planner/features/trip_lists/presentation/widgets/trip_note_card.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';

class TripNotesScreen extends ConsumerWidget {
  final String tripId;

  const TripNotesScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsProvider);
    final notesAsync = ref.watch(tripNotesProvider(tripId));

    final tripTitle = tripsAsync.maybeWhen(
      data: (trips) =>
          trips.where((t) => t.id == tripId).firstOrNull?.title ?? '',
      orElse: () => '',
    );

    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(
            direction: GradientDirection.topToBottom,
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.pop(),
            ),
            title: Text(
              tripTitle.isNotEmpty
                  ? tripTitle
                  : context.l10n.heading_trip_lists,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: notesAsync.when(
              data: (notes) {
                if (notes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_outlined,
                          size: 64,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(context.l10n.label_no_lists),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return TripNoteCard(note: note);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddNoteOptions(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _showAddNoteOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: context.colorScheme.surface.withValues(alpha: 0.85),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              border: Border.all(
                color: context.colorScheme.onSurface.withValues(alpha: 0.12),
                width: 1.5,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildOption(
                    context,
                    icon: Icons.text_fields_rounded,
                    title: context.l10n.label_add_note,
                    onTap: () {
                      context.pop();
                      _showAddNoteDialog(context, NoteType.text);
                    },
                  ),
                  _buildOption(
                    context,
                    icon: Icons.checklist_rtl_rounded,
                    title: context.l10n.label_add_checklist,
                    onTap: () {
                      context.pop();
                      _showAddNoteDialog(context, NoteType.checklist);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colorScheme.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: context.colorScheme.primary, size: 22),
      ),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: context.colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showAddNoteDialog(BuildContext context, NoteType type) {
    showDialog(
      context: context,
      builder: (context) => AddNoteDialog(tripId: tripId, type: type),
    );
  }
}
