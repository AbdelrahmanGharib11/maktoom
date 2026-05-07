import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/responsive_helper.dart';

class PaymentSummaryCard extends StatelessWidget {
  const PaymentSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w(24)),
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
          Text(
            'Payment Summary',
            style: AppTypography.headingSmall(context).copyWith(
              color: AppColors.forestGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.h(20)),
          _buildSummaryRow(context, '60-minute Video Session', '\$85.00'),
          SizedBox(height: context.h(12)),
          _buildSummaryRow(context, 'Platform Service Fee', '\$5.00'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.h(16)),
            child: Divider(color: AppColors.forestGreen.withOpacity(0.05)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTypography.headingMedium(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.forestGreen,
                ),
              ),
              Text(
                '\$90.00',
                style: AppTypography.headingMedium(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.forestGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(24)),
          Container(
            padding: EdgeInsets.all(context.w(16)),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9F0), // Warm off-white
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.mutedGold.withOpacity(0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.verified_user_rounded, color: AppColors.mutedGold, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your session is protected by end-to-end encryption and our 100% Privacy Guarantee.',
                    style: AppTypography.bodySmall(context).copyWith(
                      color: const Color(0xFF795548), // Warm brown
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textMuted),
        ),
        Text(
          value,
          style: AppTypography.bodyMedium(context).copyWith(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
