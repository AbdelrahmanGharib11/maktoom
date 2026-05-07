import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/utils/responsive_helper.dart';

class SessionTypeSelector extends StatefulWidget {
  const SessionTypeSelector({super.key});

  @override
  State<SessionTypeSelector> createState() => _SessionTypeSelectorState();
}

class _SessionTypeSelectorState extends State<SessionTypeSelector> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _types = [
    {'icon': Icons.videocam_rounded, 'label': 'Video'},
    {'icon': Icons.mic_rounded, 'label': 'Voice'},
    {'icon': Icons.chat_bubble_rounded, 'label': 'Chat'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceGreen.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(_types.length, (index) {
          final isSelected = _selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: context.h(12)),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.forestGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _types[index]['icon'],
                      size: 20,
                      color: isSelected ? Colors.white : AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _types[index]['label'],
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: isSelected ? Colors.white : AppColors.textMuted,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
