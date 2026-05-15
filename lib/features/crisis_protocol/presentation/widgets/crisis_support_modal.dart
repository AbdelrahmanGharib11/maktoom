import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/maktom_button.dart';
import '../../../../core/utils/responsive_helper.dart';

/// Global modal — triggered by AI distress detection or SOS tap.
/// Usage:
///   showModalBottomSheet(
///     context: context,
///     isScrollControlled: true,
///     backgroundColor: Colors.transparent,
///     builder: (_) => const CrisisSupportModal(),
///   );
class CrisisSupportModal extends StatelessWidget {
  const CrisisSupportModal({super.key});

  /// Convenience method to show this modal.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CrisisSupportModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFF8E1), // Very soft amber
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
        context.w(32),
        context.h(12),
        context.w(32),
        context.h(40) + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF8D6E63).withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          SizedBox(height: context.h(32)),

          Icon(
            Icons.favorite_rounded,
            color: AppColors.amber,
            size: context.w(64),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scale(
             begin: const Offset(0.9, 0.9),
             end: const Offset(1.1, 1.1),
             duration: 2.seconds,
           ),

          SizedBox(height: context.h(24)),

          Text(
            'We are here for you.',
            textAlign: TextAlign.center,
            style: AppTypography.headingLarge(context).copyWith(
              color: const Color(0xFF795548),
            ),
          ).animate().fadeIn(),

          SizedBox(height: context.h(12)),

          Text(
            'It is okay to not be okay. If you are feeling overwhelmed, '
            'we can connect you with someone immediately.',
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge(context).copyWith(
              color: const Color(0xFF8D6E63),
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 300.ms),

          SizedBox(height: context.h(40)),

          MaktomButton(
            text: 'Talk to someone now',
            onPressed: () {
              Navigator.pop(context);
              // TODO: push ActiveSession route
            },
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),

          SizedBox(height: context.h(12)),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'I\'m okay, continue',
              style: AppTypography.bodyMedium(context).copyWith(
                color: const Color(0xFF8D6E63),
                fontWeight: FontWeight.w600,
              ),
            ),
          ).animate().fadeIn(delay: 900.ms),
        ],
      ),
    );
  }
}
