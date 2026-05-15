import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../widgets/journal_streak_header.dart';
import '../widgets/journal_entry_card.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF4), // Soft off-white from image
      body: SafeArea(
        child: Column(
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.forestGreen.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outline_rounded, size: 14, color: AppColors.forestGreen),
                        const SizedBox(width: 4),
                        Text(
                          'Encrypted',
                          style: AppTypography.labelLarge(context).copyWith(
                            fontSize: 10,
                            color: AppColors.forestGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.warning_amber_rounded, color: AppColors.forestGreen),
                ],
              ),
            ),
            
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(context.w(20), context.h(20), context.w(20), context.h(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Reflection',
                            style: AppTypography.headingLarge(context).copyWith(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your thoughts are safe in this sanctuary.',
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          SizedBox(height: context.h(32)),
                          const JournalStreakHeader(),
                          SizedBox(height: context.h(32)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Entries',
                                style: AppTypography.bodyLarge(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              Icon(Icons.tune_rounded, color: AppColors.textMuted, size: context.w(20)),
                            ],
                          ),
                          SizedBox(height: context.h(20)),
                        ],
                      ),
                    ),
                  ),
                  
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const JournalEntryCard(
                          index: 0,
                          moodEmoji: '😊',
                          date: 'Saturday, Oct 21',
                          title: 'Moment of Clarity',
                          content: 'I spent the morning walking through the botanical gardens. The quiet air helped...',
                          tags: ['Peace', 'Growth'],
                        ),
                        const JournalEntryCard(
                          index: 1,
                          moodEmoji: '😐',
                          date: 'Thursday, Oct 19',
                          title: 'Seeking Balance',
                          content: 'Work has been demanding lately. I\'m trying to find boundaries but it\'s difficult...',
                          tags: [],
                        ),
                        const JournalEntryCard(
                          index: 2,
                          moodEmoji: '😊',
                          date: 'Tuesday, Oct 17',
                          title: 'Morning Stillness',
                          content: 'Woke up before the alarm today. The mist in the garden was beautiful. Captured this to remember the feeling of stillness.',
                          tags: [],
                          imagePath: 'assets/images/garden_mist.png', // Placeholder or real
                        ),
                      ]),
                    ),
                  ),
                  
                  // Bottom spacing for FAB
                  SliverToBoxAdapter(child: SizedBox(height: context.h(80))),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.forestGreen,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ).animate().scale(delay: 400.ms),

    );
  }

}
