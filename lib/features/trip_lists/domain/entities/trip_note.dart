import 'package:flutter/foundation.dart';

enum NoteType { text, checklist }

@immutable
class NoteItem {
  final String id;
  final String text;
  final bool isCompleted;

  const NoteItem({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  NoteItem copyWith({String? id, String? text, bool? isCompleted}) {
    return NoteItem(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'isCompleted': isCompleted};
  }

  factory NoteItem.fromMap(Map<String, dynamic> map) {
    return NoteItem(
      id: map['id'] as String,
      text: map['text'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteItem &&
        other.id == id &&
        other.text == text &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => Object.hash(id, text, isCompleted);
}

@immutable
class TripNote {
  final String id;
  final String tripId;
  final String title;
  final String content;
  final List<NoteItem> items;
  final NoteType type;
  final DateTime updatedAt;

  const TripNote({
    required this.id,
    required this.tripId,
    required this.title,
    this.content = '',
    this.items = const [],
    required this.type,
    required this.updatedAt,
  });

  TripNote copyWith({
    String? id,
    String? tripId,
    String? title,
    String? content,
    List<NoteItem>? items,
    NoteType? type,
    DateTime? updatedAt,
  }) {
    return TripNote(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      content: content ?? this.content,
      items: items ?? this.items,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tripId': tripId,
      'title': title,
      'content': content,
      'items': items.map((x) => x.toMap()).toList(),
      'type': type.index,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory TripNote.fromMap(Map<String, dynamic> map) {
    return TripNote(
      id: map['id'] as String,
      tripId: map['tripId'] as String,
      title: map['title'] as String,
      content: map['content'] as String? ?? '',
      items:
          (map['items'] as List?)
              ?.map(
                (x) => NoteItem.fromMap(Map<String, dynamic>.from(x as Map)),
              )
              .toList() ??
          const [],
      type: NoteType.values[map['type'] as int],
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TripNote &&
        other.id == id &&
        other.tripId == tripId &&
        other.title == title &&
        other.content == content &&
        listEquals(other.items, items) &&
        other.type == type &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    title,
    content,
    Object.hashAll(items),
    type,
    updatedAt,
  );
}
