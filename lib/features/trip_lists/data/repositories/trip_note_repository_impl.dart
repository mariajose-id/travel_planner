import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/features/trip_lists/domain/entities/trip_note.dart';
import 'package:travel_planner/features/trip_lists/domain/repositories/trip_note_repository.dart';

class TripNoteRepositoryImpl implements TripNoteRepository {
  final Box<Map> _box;

  TripNoteRepositoryImpl(this._box);

  @override
  Future<Result<List<TripNote>>> getNotes(String tripId) async {
    try {
      final notes =
          _box.values
              .map((e) => TripNote.fromMap(Map<String, dynamic>.from(e)))
              .where((note) => note.tripId == tripId)
              .toList()
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return Result.success(notes);
    } catch (e) {
      return Result.failure(
        DataError('Failed to load notes: $e', 'LOAD_NOTES_FAILED'),
      );
    }
  }

  @override
  Future<Result<void>> saveNote(TripNote note) async {
    try {
      await _box.put(note.id, note.toMap());
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        DataError('Failed to save note: $e', 'SAVE_NOTE_FAILED'),
      );
    }
  }

  @override
  Future<Result<void>> deleteNote(String noteId) async {
    try {
      await _box.delete(noteId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        DataError('Failed to delete note: $e', 'DELETE_NOTE_FAILED'),
      );
    }
  }
}
