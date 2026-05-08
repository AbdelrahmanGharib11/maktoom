import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../widgets/therapist_filter_chip.dart';
import '../widgets/therapist_grid_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../cubit/therapists_cubit.dart';

class TherapistsPage extends StatefulWidget {
  const TherapistsPage({super.key});

  @override
  State<TherapistsPage> createState() => _TherapistsPageState();
}

class _TherapistsPageState extends State<TherapistsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TherapistsCubit>()..loadTherapists(),
      child: BlocBuilder<TherapistsCubit, TherapistsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
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
                        const Icon(Icons.warning_amber_rounded, color: AppColors.forestGreen),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    const Icon(Icons.psychology_outlined, size: 14, color: AppColors.forestGreen),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Verified Experts',
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
                                context.l10n.findSupport,
                                style: AppTypography.headingLarge(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Filter Chips
                        SizedBox(
                          height: context.h(40),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                            children: [
                              _buildFilterChip(context, 'All', state),
                              _buildFilterChip(context, 'Anxiety', state),
                              _buildFilterChip(context, 'Family', state),
                              _buildFilterChip(context, 'Stress', state),
                              _buildFilterChip(context, 'Career', state),
                            ],
                          ),
                        ).animate().fadeIn().slideX(begin: 0.1, end: 0),

                        // Therapist Grid
                        Expanded(
                          child: _buildBody(context, state),
                        ).animate().fadeIn(delay: 200.ms),
                      ],
                    ),
                  ),
                ],
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
                currentIndex: 1, // Therapists
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
                  BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFD4E9E2),
                      child: Icon(Icons.psychology_rounded, color: AppColors.forestGreen, size: 20),
                    ),
                    label: 'Therapists',
                  ),
                  BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Journal'),
                  BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Circles'),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TherapistsState state) {
    if (state is TherapistsLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.forestGreen));
    } else if (state is TherapistsLoaded) {
      return GridView.builder(
        padding: EdgeInsets.all(context.w(20)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.isMobile ? 2 : 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: context.w(16),
          mainAxisSpacing: context.h(16),
        ),
        itemCount: state.therapists.length,
        itemBuilder: (context, index) {
          return TherapistGridCard(therapist: state.therapists[index]);
        },
      );
    } else if (state is TherapistsError) {
      return Center(child: Text(state.message));
    }
    return const SizedBox.shrink();
  }

  Widget _buildFilterChip(BuildContext context, String label, TherapistsState state) {
    final isSelected = state is TherapistsLoaded && (state.selectedCategory ?? 'All') == label;
    return TherapistFilterChip(
      label: label,
      isSelected: isSelected,
      onTap: () => context.read<TherapistsCubit>().selectCategory(label),
    );
  }
}
