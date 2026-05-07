import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(20), vertical: context.h(10)),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textDark),
                    onPressed: () => context.go('/'),
                  ),
                  const Spacer(),
                  Text(
                    'Profile',
                    style: AppTypography.headingMedium(context).copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.w(20)),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.surfaceGreen,
                      child: Icon(Icons.person, size: 50, color: AppColors.forestGreen),
                    ),
                    SizedBox(height: context.h(16)),
                    Text(
                      'Anonymous Soul',
                      style: AppTypography.headingLarge(context),
                    ),
                    Text(
                      'maktom_user_8231',
                      style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textMuted),
                    ),
                    SizedBox(height: context.h(32)),
                    
                    _buildProfileItem(context, Icons.security_rounded, 'Privacy Settings'),
                    _buildProfileItem(context, Icons.notifications_none_rounded, 'Notifications'),
                    _buildProfileItem(context, Icons.history_rounded, 'Session History'),
                    _buildProfileItem(context, Icons.help_outline_rounded, 'Help & Support'),
                    _buildProfileItem(context, Icons.logout_rounded, 'Logout', isDestructive: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildProfileItem(BuildContext context, IconData icon, String title, {bool isDestructive = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(12)),
      padding: EdgeInsets.all(context.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.forestGreen.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDestructive ? Colors.redAccent : AppColors.forestGreen),
          const SizedBox(width: 16),
          Text(
            title,
            style: AppTypography.bodyLarge(context).copyWith(
              color: isDestructive ? Colors.redAccent : AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_right_rounded, color: AppColors.textMuted.withOpacity(0.5)),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
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
        currentIndex: 4, // Profile
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
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology_outlined), label: 'Therapists'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Circles'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFD4E9E2),
              child: Icon(Icons.person_rounded, color: AppColors.forestGreen, size: 20),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
