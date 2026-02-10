import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/features/trip_lists/domain/entities/trip_note.dart';

abstract class TripNoteRepository {
  Future<Result<List<TripNote>>> getNotes(String tripId);
  Future<Result<void>> saveNote(TripNote note);
  Future<Result<void>> deleteNote(String noteId);
}
