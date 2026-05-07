import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/responsive_helper.dart';

class DurationSelector extends StatefulWidget {
  const DurationSelector({super.key});

  @override
  State<DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _durations = [
    {'time': '60 min', 'price': '\$85.00'},
    {'time': '120 min', 'price': '\$150.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_durations.length, (index) {
        final isSelected = _selectedIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                right: index == 0 ? context.w(12) : 0,
              ),
              padding: EdgeInsets.symmetric(vertical: context.h(24)),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.forestGreen : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.forestGreen : AppColors.forestGreen.withOpacity(0.05),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    _durations[index]['time'],
                    style: AppTypography.headingSmall(context).copyWith(
                      color: isSelected ? Colors.white : AppColors.forestGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _durations[index]['price'],
                    style: AppTypography.bodySmall(context).copyWith(
                      color: isSelected ? Colors.white.withOpacity(0.7) : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
