import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/responsive_helper.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.forestGreen),
          ),
          Text(
            'Maktom',
            style: AppTypography.headingLarge(context).copyWith(
              color: AppColors.forestGreen,
              fontSize: context.w(24),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.report_problem_outlined, color: AppColors.forestGreen),
          ),
        ],
      ),
    );
  }
}
