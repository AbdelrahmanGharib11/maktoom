import 'package:flutter/material.dart';

enum AvailabilityStatus { availableToday, availableTomorrow, waitlist }

class TherapistModel {
  final String id;
  final String name;
  final String title;
  final String bio;
  final double rating;
  final int reviewCount;
  final int pricePerHour;
  final List<String> specialties;
  final List<String> languages;
  final AvailabilityStatus availability;
  final Color avatarBgColor;
  final IconData avatarIcon;

  /// Flutter asset path to the therapist's voice introduction audio file.
  /// e.g. 'assets/audio/elena_thorne_intro.mp3'
  /// The VoicePreviewPage copies this asset to a temp file for playback.
  final String voiceIntroAssetPath;

  const TherapistModel({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
    required this.rating,
    required this.reviewCount,
    required this.pricePerHour,
    required this.specialties,
    required this.languages,
    required this.availability,
    required this.avatarBgColor,
    required this.avatarIcon,
    required this.voiceIntroAssetPath,
  });
}

/// Shared demo audio — in production each therapist has their own recording.
const _kDemoAudio = 'assets/audio/therapist_intro.mp3';

const kTherapists = [
  TherapistModel(
    id: 'elena-thorne',
    name: 'Dr. Elena Thorne',
    title: 'Clinical Psychologist',
    bio: 'Specializing in cognitive behavioral therapy and mindful resilience for high-stress environments.',
    rating: 4.9,
    reviewCount: 142,
    pricePerHour: 120,
    specialties: ['Anxiety', 'Stress', 'CBT'],
    languages: ['English', 'French'],
    availability: AvailabilityStatus.availableToday,
    avatarBgColor: Color(0xFFD8EFE3),
    avatarIcon: Icons.person_rounded,
    voiceIntroAssetPath: _kDemoAudio,
  ),
  TherapistModel(
    id: 'marcus-chen',
    name: 'Marcus Chen, LPC',
    title: 'Licensed Professional Counselor',
    bio: 'Focused on career transitions, identity, and balancing professional ambition with emotional health.',
    rating: 4.8,
    reviewCount: 98,
    pricePerHour: 95,
    specialties: ['Career', 'Identity', 'Relationships'],
    languages: ['English', 'Mandarin'],
    availability: AvailabilityStatus.availableTomorrow,
    avatarBgColor: Color(0xFFE6F4EC),
    avatarIcon: Icons.person_rounded,
    voiceIntroAssetPath: _kDemoAudio,
  ),
  TherapistModel(
    id: 'sarah-miller',
    name: 'Sarah J. Miller',
    title: 'Trauma Specialist',
    bio: 'Trauma-informed specialist with a focus on holistic healing and interpersonal relationships.',
    rating: 4.9,
    reviewCount: 207,
    pricePerHour: 110,
    specialties: ['Trauma', 'Holistic', 'Relationships'],
    languages: ['English'],
    availability: AvailabilityStatus.availableToday,
    avatarBgColor: Color(0xFFFFF8EC),
    avatarIcon: Icons.person_rounded,
    voiceIntroAssetPath: _kDemoAudio,
  ),
  TherapistModel(
    id: 'david-oreilly',
    name: "David O'Reilly",
    title: 'Addiction Recovery Specialist',
    bio: 'Addiction recovery and impulse control specialist using evidence-based therapeutic techniques.',
    rating: 4.7,
    reviewCount: 73,
    pricePerHour: 85,
    specialties: ['Addiction', 'Recovery', 'CBT'],
    languages: ['English'],
    availability: AvailabilityStatus.waitlist,
    avatarBgColor: Color(0xFFEAE4F7),
    avatarIcon: Icons.person_rounded,
    voiceIntroAssetPath: _kDemoAudio,
  ),
  TherapistModel(
    id: 'maya-kapoor',
    name: 'Dr. Maya Kapoor',
    title: "Women's Wellness Specialist",
    bio: "Deeply specialized in postnatal mental health and women's wellness through life transitions.",
    rating: 5.0,
    reviewCount: 186,
    pricePerHour: 130,
    specialties: ["Women's Health", 'Postnatal', 'Wellness'],
    languages: ['English', 'Hindi'],
    availability: AvailabilityStatus.availableToday,
    avatarBgColor: Color(0xFFFFE8E8),
    avatarIcon: Icons.person_rounded,
    voiceIntroAssetPath: _kDemoAudio,
  ),
];

const kFilterCategories = ['All', 'Anxiety', 'Family', 'Stress', 'Career', 'Trauma', 'Relationships'];
