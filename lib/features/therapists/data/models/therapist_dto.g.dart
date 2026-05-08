// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TherapistDTO _$TherapistDTOFromJson(Map<String, dynamic> json) => TherapistDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      bio: json['bio'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      isVerified: json['isVerified'] as bool? ?? false,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hourlyRate: (json['hourlyRate'] as num).toDouble(),
    );

Map<String, dynamic> _$TherapistDTOToJson(TherapistDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'specialty': instance.specialty,
      'bio': instance.bio,
      'avatarUrl': instance.avatarUrl,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'isVerified': instance.isVerified,
      'categories': instance.categories,
      'hourlyRate': instance.hourlyRate,
    };
