import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class ResourceLibraryPage extends StatelessWidget {
  const ResourceLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF4),
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(20),
                vertical: context.h(10),
              ),
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
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.forestGreen,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(context.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGreen.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.psychology_outlined,
                            size: 14,
                            color: AppColors.forestGreen,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Professional Repository',
                            style: AppTypography.bodyMedium(context).copyWith(
                              fontSize: 10,
                              color: AppColors.forestGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.h(12)),
                    Text(
                      'Resource Library',
                      style: AppTypography.headingLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: context.h(8)),
                    Text(
                      'Curated therapeutic tools to share with your clients. Support their journey with grounding techniques and mindful exercises.',
                      style: AppTypography.bodyMedium(
                        context,
                      ).copyWith(color: AppColors.textMuted),
                    ),

                    SizedBox(height: context.h(24)),

                    // Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(context, 'All Resources', true),
                          _buildFilterChip(context, 'Breathing', false),
                          _buildFilterChip(context, 'Grounding', false),
                          _buildFilterChip(context, 'Articles', false),
                        ],
                      ),
                    ),

                    SizedBox(height: context.h(32)),

                    // Resource List
                    _buildResourceCard(
                      context,
                      type: 'BREATHING',
                      title: 'Box Breathing Technique',
                      description:
                          'A simple but powerful tool for resetting the nervous system during moments of acute stress or panic.',
                      actionText: 'Send to Sarah W.',
                      imagePath: 'assets/images/resource_breathing.png',
                      isPrimary: true,
                    ),
                    _buildResourceCard(
                      context,
                      type: 'GROUNDING',
                      title: 'The 5-4-3-2-1 Method',
                      description:
                          'Sensory awareness technique to pull a client back from dissociation or overwhelm.',
                      actionText: 'Send to Marcus E.',
                      imagePath: 'assets/images/resource_grounding.png',
                    ),
                    _buildResourceCard(
                      context,
                      type: 'ARTICLE',
                      title: 'Understanding Vagus Nerve Tone',
                      description:
                          'Client-friendly explanation of why the body stays in fight or flight mode after trauma.',
                      actionText: 'Send to Julia B.',
                      icon: Icons.article_outlined,
                    ),

                    SizedBox(height: context.h(32)),
                    Text(
                      'Recently Shared with Clients',
                      style: AppTypography.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: context.h(16)),
                    _buildSharedItem(
                      context,
                      'Sarah W.',
                      'Box Breathing Technique',
                      '2 hours ago',
                      'SW',
                    ),
                    _buildSharedItem(
                      context,
                      'Marcus E.',
                      'The 5-4-3-2-1 Method',
                      '5 hours ago',
                      'ME',
                    ),

                    SizedBox(height: context.h(80)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.forestGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.forestGreen : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? AppColors.forestGreen
              : AppColors.forestGreen.withOpacity(0.1),
        ),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall(context).copyWith(
          color: isSelected ? Colors.white : AppColors.forestGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context, {
    required String type,
    required String title,
    required String description,
    required String actionText,
    String? imagePath,
    IconData? icon,
    bool isPrimary = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          if (imagePath != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: context.h(140),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: context.h(140),
                  color: AppColors.surfaceGreen.withOpacity(0.2),
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppColors.forestGreen,
                  ),
                ),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(context.w(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon ?? Icons.waves_rounded,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      type,
                      style: AppTypography.bodyLarge(context).copyWith(
                        fontSize: 10,
                        color: AppColors.textMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.h(8)),
                Text(
                  title,
                  style: AppTypography.headingSmall(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: context.h(8)),
                Text(
                  description,
                  style: AppTypography.bodyMedium(
                    context,
                  ).copyWith(color: AppColors.textMuted, height: 1.4),
                ),
                SizedBox(height: context.h(16)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPrimary
                        ? AppColors.forestGreen
                        : const Color(0xFFF1F2E9),
                    foregroundColor: isPrimary
                        ? Colors.white
                        : AppColors.forestGreen,
                    elevation: 0,
                    minimumSize: Size(double.infinity, context.h(48)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send_rounded,
                        size: 16,
                        color: isPrimary ? Colors.white : AppColors.forestGreen,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        actionText,
                        style: AppTypography.bodyMedium(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedItem(
    BuildContext context,
    String name,
    String tool,
    String time,
    String initials,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(12)),
      padding: EdgeInsets.all(context.w(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.surfaceGreen,
            child: Text(
              initials,
              style: const TextStyle(
                color: AppColors.forestGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$tool • $time',
                  style: AppTypography.bodySmall(
                    context,
                  ).copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.forestGreen,
            size: 20,
          ),
        ],
      ),
    );
  }
}
