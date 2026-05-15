import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/circle_card.dart';
import '../widgets/circle_category_chip.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/l10n_extensions.dart';

class CirclesPage extends StatelessWidget {
  const CirclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(20), vertical: context.h(10)),
              child: Row(
                children: [
                  const Icon(Icons.menu_rounded, color: AppColors.textDark),
                  const Spacer(),
                  Text(
                    'Maktom',
                    style: AppTypography.headingMedium(context).copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.warning_amber_rounded, color: AppColors.forestGreen),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(context.w(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGreen.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.groups_outlined, size: 14, color: AppColors.forestGreen),
                        const SizedBox(width: 6),
                        Text(
                          'Community Spaces',
                          style: AppTypography.labelLarge(context).copyWith(
                            fontSize: 10,
                            color: AppColors.forestGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.h(12)),
                  Text(
                    context.l10n.communityCircles,
                    style: AppTypography.headingLarge(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: context.h(8)),
                  Text(
                    'Join a safe space to share and listen anonymously.',
                    style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            
            // Categories
            SizedBox(
              height: context.h(40),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                children: const [
                  CircleCategoryChip(label: 'Trending'),
                  CircleCategoryChip(label: 'Anxiety'),
                  CircleCategoryChip(label: 'Relationships'),
                  CircleCategoryChip(label: 'Work Life'),
                ],
              ),
            ).animate().fadeIn().slideX(begin: 0.1, end: 0),

            SizedBox(height: context.h(24)),

            // Circle Cards
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final titles = [
                    'Managing Work Stress',
                    'Quiet Reflection Group',
                    'Parenthood Support',
                    'Social Anxiety Helpers'
                  ];
                  return CircleCard(title: titles[index], index: index);
                },
              ),
            ).animate().fadeIn(delay: 200.ms),
          ],
        ),
      ),

    );
  }
}
