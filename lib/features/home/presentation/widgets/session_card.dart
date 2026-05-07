import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/maktom_button.dart';
import '../../../../core/utils/l10n_extensions.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.forestGreen,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/splash_bg.png'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                context.l10n.upcomingSession,
                style: AppTypography.bodySmall(context).copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Session with Dr. Sarah', // Placeholder
            style: AppTypography.headingMedium(context).copyWith(color: Colors.white),
          ),
          Text(
            'Today at 5:30 PM', // Placeholder
            style: AppTypography.bodyMedium(context).copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          MaktomButton(
            text: context.l10n.joinSession,
            onPressed: () {},
            isSecondary: true,
          ),
        ],
      ),
    );
  }
}
