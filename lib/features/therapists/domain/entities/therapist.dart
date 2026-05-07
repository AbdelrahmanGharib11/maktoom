import 'package:equatable/equatable.dart';

class Therapist extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String avatar;
  final List<String> languages;
  final double rating;
  final double pricePerHour;
  final bool isAvailableToday;

  const Therapist({
    required this.id,
    required this.name,
    required this.specialty,
    required this.avatar,
    required this.languages,
    required this.rating,
    required this.pricePerHour,
    required this.isAvailableToday,
  });

  @override
  List<Object?> get props => [id, name, specialty, avatar, languages, rating, pricePerHour, isAvailableToday];
}
