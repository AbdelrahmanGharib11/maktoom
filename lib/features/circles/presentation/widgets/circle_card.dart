import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class CircleCard extends StatelessWidget {
  final String title;
  final int index;

  const CircleCard({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(16)),
      padding: EdgeInsets.all(context.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.w(24)),
        border: Border.all(color: AppColors.surfaceGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mutedGold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined, color: AppColors.mutedGold, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Moderated', // Could be localized
                      style: AppTypography.bodySmall(context).copyWith(
                        color: AppColors.mutedGold,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '12 Active', 
                style: AppTypography.bodySmall(context).copyWith(fontSize: 10),
              ),
            ],
          ),
          SizedBox(height: context.h(16)),
          Text(
            title,
            style: AppTypography.headingMedium(context),
          ),
          SizedBox(height: context.h(8)),
          Text(
            'Share your experiences and find support from others facing similar challenges.',
            style: AppTypography.bodySmall(context),
          ),
          SizedBox(height: context.h(20)),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: Stack(
                    children: List.generate(3, (i) => Positioned(
                      left: i * 20.0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: [AppColors.warmSage, AppColors.forestGreen, AppColors.mutedGold][i],
                          child: const Icon(Icons.person, size: 12, color: Colors.white),
                        ),
                      ),
                    )),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forestGreen,
                  foregroundColor: Colors.white,
                  minimumSize: Size(context.w(100), context.h(36)),
                  padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  'Join Circle', 
                  style: AppTypography.bodySmall(context).copyWith(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1, end: 0);
  }
}
