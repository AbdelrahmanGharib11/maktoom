import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/mood_picker.dart';
import '../widgets/greeting_header.dart';
import '../widgets/session_card.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/l10n_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const GreetingHeader().animate().fadeIn().slideX(begin: -0.1, end: 0),

              const SizedBox(height: 32),

              // Mood Check-in
              Text(
                context.l10n.moodCheckIn,
                style: AppTypography.headingSmall(context),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 16),
              MoodPicker(
                onMoodSelected: (mood) {
                  // Handle mood selection
                },
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 32),

              // Quick Check-in (Premium Feature)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.forestGreen, Color(0xFF1E3A34)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.forestGreen.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.mutedGold.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'QUICK SUPPORT',
                              style: AppTypography.labelLarge(context).copyWith(
                                color: AppColors.mutedGold,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Need a 5-min gut-check?',
                            style: AppTypography.headingSmall(context).copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Connect with a therapist instantly for a rapid session.',
                            style: AppTypography.bodySmall(context).copyWith(color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mutedGold,
                        foregroundColor: AppColors.forestGreen,
                        minimumSize: const Size(0, 48), // Override global infinite width
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: const Text('Start Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0),

              const SizedBox(height: 32),

              // Upcoming Session Card
              const SessionCard().animate().fadeIn(delay: 400.ms).scale(),

              const SizedBox(height: 32),

              // Therapist CTA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.needToTalk,
                    style: AppTypography.headingSmall(context),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      context.l10n.seeAll,
                      style: AppTypography.bodyMedium(context).copyWith(color: AppColors.warmSage),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Horizontal Therapist List Placeholder
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.surfaceGreen,
                            child: Icon(Icons.psychology, color: AppColors.forestGreen, size: 30),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Dr. Amina',
                            style: AppTypography.bodyLarge(context).copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Family Expert',
                            style: AppTypography.bodySmall(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9F0),
          border: Border(top: BorderSide(color: AppColors.forestGreen.withOpacity(0.05))),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.forestGreen,
          unselectedItemColor: AppColors.textMuted,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (index) {
            switch (index) {
              case 0: context.go('/'); break;
              case 1: context.go('/therapists'); break;
              case 2: context.go('/journal'); break;
              case 3: context.go('/circles'); break;
              case 4: context.go('/profile'); break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFD4E9E2),
                child: Icon(Icons.home_rounded, color: AppColors.forestGreen, size: 20),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.psychology_outlined), label: 'Therapists'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Journal'),
            BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Circles'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
