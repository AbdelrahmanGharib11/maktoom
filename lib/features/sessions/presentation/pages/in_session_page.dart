import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class InSessionPage extends StatelessWidget {
  const InSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF4),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(20), vertical: context.h(10)),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.forestGreen, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Maktom',
                    style: AppTypography.headingMedium(context).copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '42:15',
                          style: AppTypography.bodySmall(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Sub Header & Alias Banner
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(20), vertical: context.h(4)),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified_user_rounded, size: 14, color: AppColors.forestGreen),
                      const SizedBox(width: 6),
                      Text(
                        'End-to-End Encrypted Session',
                        style: AppTypography.bodySmall(context).copyWith(
                          color: AppColors.forestGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.emergency_share_rounded, size: 18, color: Colors.redAccent),
                    ],
                  ),
                  SizedBox(height: context.h(8)),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.mutedGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.mutedGold.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.masks_rounded, size: 18, color: AppColors.mutedGold),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YOUR SESSION ALIAS',
                              style: AppTypography.labelLarge(context).copyWith(
                                fontSize: 9,
                                letterSpacing: 1.2,
                                color: AppColors.mutedGold,
                              ),
                            ),
                            Text(
                              'Kept_Secret_823',
                              style: AppTypography.bodyMedium(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'Private',
                          style: AppTypography.bodySmall(context).copyWith(
                            color: AppColors.mutedGold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 1),

            // Central Avatar Area
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: context.w(280),
                    height: context.w(280),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceGreen.withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/therapist_large.png'), // Placeholder
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Speaking Badge
                  Container(
                    margin: EdgeInsets.only(bottom: context.h(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.forestGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.graphic_eq_rounded, color: Colors.white, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Speaking',
                          style: AppTypography.bodySmall(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.h(24)),

            // Doctor Info
            Text(
              'Dr. Elena Thorne',
              style: AppTypography.headingLarge(context).copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            Text(
              'Clinical Psychologist',
              style: AppTypography.bodyLarge(context).copyWith(color: AppColors.textMuted),
            ),

            const Spacer(flex: 2),

            // Connection Status & Notes
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEFE4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.edit_note_rounded, color: AppColors.textDark, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Notes',
                          style: AppTypography.bodySmall(context).copyWith(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.signal_cellular_alt_rounded, color: AppColors.textMuted, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Stable',
                        style: AppTypography.bodySmall(context).copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: context.h(20)),

            // Call Controls
            Container(
              margin: EdgeInsets.all(context.w(20)),
              padding: EdgeInsets.symmetric(vertical: context.h(12), horizontal: context.w(20)),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEFE4),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(context, Icons.mic_none_rounded),
                  _buildControlButton(context, Icons.videocam_outlined),
                  const SizedBox(width: 12),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.black12,
                  ),
                  const SizedBox(width: 12),
                  _buildEndButton(context),
                ],
              ),
            ),
            
            SizedBox(height: context.h(10)),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(BuildContext context, IconData icon) {
    return Container(
      width: context.w(56),
      height: context.w(56),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.textDark, size: 28),
    );
  }

  Widget _buildEndButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.w(32), vertical: context.h(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFC62828),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC62828).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.call_end_rounded, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Text(
            'End',
            style: AppTypography.bodyLarge(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
