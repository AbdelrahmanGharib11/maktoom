import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../domain/entities/therapist_model.dart';

class TherapistCard extends StatelessWidget {
  final TherapistModel therapist;
  final int index;

  const TherapistCard({
    super.key,
    required this.therapist,
    required this.index,
  });

  String get _availabilityLabel {
    switch (therapist.availability) {
      case AvailabilityStatus.availableToday:
        return 'Available Today';
      case AvailabilityStatus.availableTomorrow:
        return 'Tomorrow';
      case AvailabilityStatus.waitlist:
        return 'Waitlist';
    }
  }

  Color get _availabilityColor {
    switch (therapist.availability) {
      case AvailabilityStatus.availableToday:
        return AppColors.forestGreen;
      case AvailabilityStatus.availableTomorrow:
        return AppColors.warmSage;
      case AvailabilityStatus.waitlist:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: context.h(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.forestGreen.withAlpha(12),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () => context.push('/app/therapists/${therapist.id}'),
              borderRadius: BorderRadius.circular(20),
              splashColor: AppColors.surfaceGreen.withAlpha(100),
              highlightColor: AppColors.surfaceGreen.withAlpha(50),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Row 1: Avatar + Info ─────────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar — tap plays voice intro
                        GestureDetector(
                          onTap: () =>
                              context.push('/app/therapists/${therapist.id}'),
                          child: Stack(
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: therapist.avatarBgColor,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/therapist_1.png',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                          Icons.person_rounded,
                                          size: 38,
                                          color: AppColors.forestGreen
                                              .withAlpha(160),
                                        ),
                                  ),
                                ),
                              ),
                              // Online dot
                              if (therapist.availability ==
                                  AvailabilityStatus.availableToday)
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF22C55E),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Name + title + rating
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Availability + Rating row
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _availabilityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _availabilityLabel,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: _availabilityColor,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFD4A843),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${therapist.rating}',
                                    style: AppTypography.bodySmall(context)
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                  ),
                                  Text(
                                    ' (${therapist.reviewCount})',
                                    style: AppTypography.bodySmall(context)
                                        .copyWith(
                                          color: AppColors.textMuted,
                                          fontSize: 11,
                                        ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                therapist.name,
                                style: AppTypography.bodyLarge(context)
                                    .copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textDark,
                                      fontSize: 16,
                                    ),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                therapist.title,
                                style: AppTypography.bodySmall(context)
                                    .copyWith(
                                      color: AppColors.warmSage,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ── Bio ──────────────────────────────────────────────────
                    Text(
                      therapist.bio,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: AppColors.textMuted,
                        height: 1.55,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // ── Specialty chips ──────────────────────────────────────
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: therapist.specialties.map((s) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softOffWhite,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.surfaceGreen),
                          ),
                          child: Text(
                            s,
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.forestGreen,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // ── Bottom: Price + Buttons ──────────────────────────────
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${therapist.pricePerHour}',
                              style: AppTypography.bodyLarge(context).copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'per session',
                              style: AppTypography.bodySmall(context).copyWith(
                                color: AppColors.textMuted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // View Profile button
                        OutlinedButton(
                          onPressed: () =>
                              context.push('/app/therapists/${therapist.id}'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.forestGreen,
                            side: const BorderSide(
                              color: AppColors.forestGreen,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Profile',
                            style: AppTypography.bodySmall(context).copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.forestGreen,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Book Session button
                        ElevatedButton(
                          onPressed: () => context.push(
                            '/app/therapists/${therapist.id}/book',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.forestGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Book',
                            style: AppTypography.bodySmall(context).copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 60 * index),
          duration: 400.ms,
        )
        .slideY(
          begin: 0.08,
          end: 0,
          delay: Duration(milliseconds: 60 * index),
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
