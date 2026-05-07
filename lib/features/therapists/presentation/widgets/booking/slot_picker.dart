import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/responsive_helper.dart';

class SlotPicker extends StatefulWidget {
  const SlotPicker({super.key});

  @override
  State<SlotPicker> createState() => _SlotPickerState();
}

class _SlotPickerState extends State<SlotPicker> {
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 2; // Defaulting to one of the slots

  final List<Map<String, String>> _dates = [
    {'day': 'Mon', 'date': '14'},
    {'day': 'Tue', 'date': '15'},
    {'day': 'Wed', 'date': '16'},
    {'day': 'Thu', 'date': '17'},
    {'day': 'Fri', 'date': '18'},
  ];

  final List<String> _times = [
    '09:00 AM', '10:30 AM', '11:00 AM',
    '01:30 PM', '03:00 PM', '04:30 PM',
    '06:00 PM', '07:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available Slots',
              style: AppTypography.headingSmall(context).copyWith(
                color: AppColors.forestGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  'October 2024',
                  style: AppTypography.bodySmall(context).copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_left_rounded, size: 20, color: AppColors.textMuted),
                const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.textMuted),
              ],
            ),
          ],
        ),
        SizedBox(height: context.h(16)),
        
        // Date Stripe
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_dates.length, (index) {
              final isSelected = _selectedDateIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedDateIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: context.w(12)),
                  padding: EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(12)),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.surfaceGreen : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.forestGreen : AppColors.forestGreen.withOpacity(0.05),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _dates[index]['day']!,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: isSelected ? AppColors.forestGreen : AppColors.textMuted,
                        ),
                      ),
                      Text(
                        _dates[index]['date']!,
                        style: AppTypography.headingSmall(context).copyWith(
                          color: AppColors.forestGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        
        SizedBox(height: context.h(24)),
        
        // Time Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: context.h(12),
            crossAxisSpacing: context.w(12),
            childAspectRatio: 2.2,
          ),
          itemCount: _times.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedTimeIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedTimeIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.forestGreen : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.forestGreen : AppColors.forestGreen.withOpacity(0.05),
                  ),
                ),
                child: Text(
                  _times[index],
                  style: AppTypography.bodySmall(context).copyWith(
                    color: isSelected ? Colors.white : AppColors.forestGreen,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
