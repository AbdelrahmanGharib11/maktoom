import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class JournalEntryCard extends StatelessWidget {
  final String moodEmoji;
  final String date;
  final String title;
  final String content;
  final List<String> tags;
  final String? imagePath;
  final int index;

  const JournalEntryCard({
    super.key,
    required this.moodEmoji,
    required this.date,
    required this.title,
    required this.content,
    required this.tags,
    this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(20)),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                imagePath!,
                width: double.infinity,
                height: context.h(160),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: context.h(160),
                  color: AppColors.surfaceGreen.withOpacity(0.3),
                  child: const Icon(Icons.image_outlined, color: AppColors.forestGreen),
                ),
              ),
            ),
          
          Padding(
            padding: EdgeInsets.all(context.w(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGreen.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(moodEmoji, style: const TextStyle(fontSize: 20)),
                    ),
                    SizedBox(width: context.w(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date.toUpperCase(),
                            style: AppTypography.labelLarge(context).copyWith(
                              fontSize: 10,
                              color: AppColors.textMuted,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            title,
                            style: AppTypography.headingSmall(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.more_horiz_rounded, color: AppColors.textMuted.withOpacity(0.5)),
                  ],
                ),
                SizedBox(height: context.h(12)),
                Text(
                  content,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: AppColors.textMuted,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (tags.isNotEmpty) ...[
                  SizedBox(height: context.h(12)),
                  Wrap(
                    spacing: 8,
                    children: tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.softOffWhite,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '#$tag',
                        style: AppTypography.bodySmall(context).copyWith(
                          color: AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (150 * index).ms).slideY(begin: 0.1, end: 0);
  }
}
