import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/features/trip_lists/domain/entities/trip_note.dart';
import 'package:travel_planner/features/trip_lists/domain/repositories/trip_note_repository.dart';

final tripNotesProvider =
    AsyncNotifierProvider.family<TripNotesNotifier, List<TripNote>, String>(
      TripNotesNotifier.new,
    );

class TripNotesNotifier extends FamilyAsyncNotifier<List<TripNote>, String> {
  late TripNoteRepository _repository;
  late String _tripId;

  @override
  FutureOr<List<TripNote>> build(String arg) async {
    _tripId = arg;
    _repository = serviceLocator<TripNoteRepository>();

    final result = await _repository.getNotes(_tripId);
    if (result.isSuccess) {
      return result.value!;
    }
    throw Exception(result.error?.message ?? 'Failed to load notes');
  }

  Future<void> saveNote(TripNote note) async {
    final previousState = await future;

    // Optimistic update
    final index = previousState.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      // Update
      state = AsyncData(
        previousState.map((n) => n.id == note.id ? note : n).toList()
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)),
      );
    } else {
      // Add
      state = AsyncData(
        [note, ...previousState]
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)),
      );
    }

    final result = await _repository.saveNote(note);
    if (result.isFailure) {
      // Revert on failure
      state = AsyncData(previousState);
      throw Exception(result.error?.message);
    }
  }

  Future<void> deleteNote(String noteId) async {
    final previousState = await future;

    // Optimistic update
    state = AsyncData(previousState.where((n) => n.id != noteId).toList());

    final result = await _repository.deleteNote(noteId);
    if (result.isFailure) {
      // Revert on failure
      state = AsyncData(previousState);
      throw Exception(result.error?.message);
    }
  }
}
