import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class JournalStreakHeader extends StatelessWidget {
  const JournalStreakHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w(20)),
      decoration: BoxDecoration(
        color: AppColors.surfaceGreen.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.forestGreen.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WEEKLY PATH',
                style: AppTypography.labelLarge(context).copyWith(
                  color: AppColors.forestGreen.withOpacity(0.6),
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '12 Day Streak',
                style: AppTypography.bodySmall(context).copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
              final moods = ['😊', '😁', '😊', '😐', '😊', '😄', '?'];
              final isCurrent = index == 5; // Saturday in the image
              
              return Column(
                children: [
                  Text(
                    days[index],
                    style: AppTypography.bodySmall(context).copyWith(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: context.h(8)),
                  Container(
                    width: context.w(36),
                    height: context.w(36),
                    decoration: BoxDecoration(
                      color: isCurrent ? AppColors.forestGreen : (moods[index] == '?' ? Colors.transparent : AppColors.warmSage.withOpacity(0.2)),
                      shape: BoxShape.circle,
                      border: moods[index] == '?' ? Border.all(color: AppColors.textMuted.withOpacity(0.3), style: BorderStyle.none) : null,
                    ),
                    child: Center(
                      child: moods[index] == '?' 
                        ? Icon(Icons.help_outline, size: 16, color: AppColors.textMuted.withOpacity(0.3))
                        : Text(
                            moods[index],
                            style: TextStyle(fontSize: isCurrent ? 18 : 16),
                          ),
                    ),
                  ),
                  if (moods[index] == '?')
                    const SizedBox() // Placeholder for dashed circle in image
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
