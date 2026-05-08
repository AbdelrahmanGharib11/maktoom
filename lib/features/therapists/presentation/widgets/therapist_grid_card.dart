import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

import '../../data/models/therapist_dto.dart';

class TherapistGridCard extends StatelessWidget {
  final TherapistDTO therapist;

  const TherapistGridCard({super.key, required this.therapist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/booking'),
      borderRadius: BorderRadius.circular(context.w(24)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.w(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Area
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGreen,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(context.w(24))),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/therapist_1.png',
                        width: context.w(80),
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 40, color: AppColors.forestGreen),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_circle_fill, color: AppColors.forestGreen, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Intro',
                            style: AppTypography.bodySmall(context).copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: AppColors.forestGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Info Area
            Padding(
              padding: EdgeInsets.all(context.w(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.warmSage.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Available',
                          style: AppTypography.bodySmall(context).copyWith(
                            color: AppColors.forestGreen,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.mutedGold, size: 10),
                          const SizedBox(width: 2),
                          Text(
                            therapist.rating.toString(),
                            style: AppTypography.bodySmall(context).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.h(8)),
                  Text(
                    therapist.name,
                    style: AppTypography.bodyMedium(context).copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    therapist.specialty,
                    style: AppTypography.bodySmall(context).copyWith(fontSize: 10),
                  ),
                  SizedBox(height: context.h(8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${therapist.hourlyRate.toInt()}/hr',
                        style: AppTypography.bodySmall(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.forestGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
