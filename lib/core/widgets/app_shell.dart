import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final String location;

  const AppShell({
    super.key,
    required this.navigationShell,
    required this.location,
  });

  static const _tabRootPaths = {
    '/app/home',
    '/app/therapists',
    '/app/journal',
    '/app/circles',
    '/app/profile',
  };

  @override
  Widget build(BuildContext context) {
    final showBottomNav = _tabRootPaths.contains(location);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: showBottomNav
          ? _MaktomBottomNav(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                HapticFeedback.selectionClick();
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            )
          : null,
    );
  }
}

class _MaktomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _MaktomBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  static const _tabs = [
    _TabItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _TabItem(
      icon: Icons.spa_outlined,
      activeIcon: Icons.spa_rounded,
      label: 'Therapists',
    ),
    _TabItem(
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book_rounded,
      label: 'Journal',
    ),
    _TabItem(
      icon: Icons.groups_outlined,
      activeIcon: Icons.groups_rounded,
      label: 'Circles',
    ),
    _TabItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softOffWhite,
        border: Border(
          top: BorderSide(
            color: AppColors.forestGreen.withOpacity(0.05),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withAlpha(10),
            blurRadius: 15,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isActive = index == currentIndex;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(index),
                  child: _TabButton(tab: tab, isActive: isActive),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _TabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _TabButton extends StatelessWidget {
  final _TabItem tab;
  final bool isActive;

  const _TabButton({
    required this.tab,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: 250.ms,
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.surfaceGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: 200.ms,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                  ),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                isActive ? tab.activeIcon : tab.icon,
                key: ValueKey('${tab.label}-$isActive'),
                color: isActive ? AppColors.forestGreen : const Color(0xFF5A6660),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: 200.ms,
              style: TextStyle(
                color: isActive ? AppColors.forestGreen : const Color(0xFF5A6660),
                fontFamily: 'Manrope',
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              ),
              child: Text(tab.label),
            ),
          ],
        ),
      ),
    );
  }
}
