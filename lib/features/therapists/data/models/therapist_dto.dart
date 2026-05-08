import 'package:json_annotation/json_annotation.dart';

part 'therapist_dto.g.dart';

@JsonSerializable()
class TherapistDTO {
  final String id;
  final String name;
  final String specialty;
  final String bio;
  final String? avatarUrl;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final List<String> categories;
  final double hourlyRate;

  TherapistDTO({
    required this.id,
    required this.name,
    required this.specialty,
    required this.bio,
    this.avatarUrl,
    required this.rating,
    required this.reviewCount,
    this.isVerified = false,
    required this.categories,
    required this.hourlyRate,
  });

  factory TherapistDTO.fromJson(Map<String, dynamic> json) => _$TherapistDTOFromJson(json);
  Map<String, dynamic> json() => _$TherapistDTOToJson(this);
}
