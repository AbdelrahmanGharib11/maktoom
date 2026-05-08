import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/locale_cubit.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.goodMorning,
                  style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textMuted),
                ),
                Text(
                  'Abdelrahman',
                  style: AppTypography.headingMedium(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => sl<LocaleCubit>().toggleLocale(),
              icon: const Icon(Icons.language_rounded, color: AppColors.forestGreen),
            ),
          ],
        ),
      ],
    );
  }
}
