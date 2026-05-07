import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/locale_provider.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.l10n.goodMorning;
    if (hour < 17) return context.l10n.goodAfternoon;
    return context.l10n.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_getGreeting(context)},',
              style: AppTypography.bodyLarge(
                context,
              ).copyWith(color: AppColors.textMuted),
            ),
            Text(
              context.l10n.friend,
              style: AppTypography.headingLarge(context),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => sl<LocaleProvider>().toggleLocale(),
              icon: const Icon(Icons.language, color: AppColors.forestGreen),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.surfaceGreen,
              child: Icon(Icons.person_outline, color: AppColors.forestGreen),
            ),
          ],
        ),
      ],
    );
  }
}
