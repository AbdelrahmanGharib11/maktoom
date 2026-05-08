import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../widgets/booking/booking_header.dart';
import '../widgets/booking/session_type_selector.dart';
import '../widgets/booking/duration_selector.dart';
import '../widgets/booking/slot_picker.dart';
import '../widgets/booking/payment_summary_card.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softOffWhite,
      body: SafeArea(
        child: Column(
          children: [
            const BookingHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.w(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.h(20)),

                    // Therapist Header
                    Container(
                      padding: EdgeInsets.all(context.w(16)),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.forestGreen.withOpacity(0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/therapist_1.png',
                            ),
                          ),
                          SizedBox(width: context.w(16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Elara Vance',
                                  style: AppTypography.headingMedium(
                                    context,
                                  ).copyWith(color: AppColors.forestGreen),
                                ),
                                Text(
                                  'Cognitive Behavioral Specialist',
                                  style: AppTypography.bodyMedium(
                                    context,
                                  ).copyWith(color: AppColors.textMuted),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.mutedGold,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '4.9 (124 reviews)',
                                      style: AppTypography.bodySmall(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.h(30)),

                    Text(
                      'SELECT SESSION TYPE',
                      style: AppTypography.bodyLarge(context).copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: context.h(12)),
                    const SessionTypeSelector(),

                    SizedBox(height: context.h(30)),

                    Text(
                      'DURATION',
                      style: AppTypography.bodyLarge(context).copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: context.h(12)),
                    const DurationSelector(),

                    SizedBox(height: context.h(30)),

                    const SlotPicker(),

                    SizedBox(height: context.h(30)),

                    const PaymentSummaryCard(),

                    SizedBox(height: context.h(40)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(context.w(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.forestGreen,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, context.h(64)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Confirm & Pay',
                style: AppTypography.headingSmall(
                  context,
                ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
