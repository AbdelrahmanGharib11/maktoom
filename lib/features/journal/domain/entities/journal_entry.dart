import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable {
  final String id;
  final String content;
  final String mood;
  final DateTime createdAt;

  const JournalEntry({
    required this.id,
    required this.content,
    required this.mood,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, content, mood, createdAt];
}
