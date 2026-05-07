import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive_helper.dart';

class MoodPicker extends StatefulWidget {
  final Function(String) onMoodSelected;

  const MoodPicker({super.key, required this.onMoodSelected});

  @override
  State<MoodPicker> createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  String? _selectedMood;

  final List<Map<String, String>> _moods = [
    {'emoji': '😌', 'label': 'Calm'},
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😔', 'label': 'Sad'},
    {'emoji': '😰', 'label': 'Anxious'},
    {'emoji': '🧘', 'label': 'Reflective'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _moods.map((mood) {
        final isSelected = _selectedMood == mood['label'];
        return GestureDetector(
          onTap: () {
            setState(() => _selectedMood = mood['label']);
            widget.onMoodSelected(mood['label']!);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: context.w(60),
            padding: EdgeInsets.symmetric(vertical: context.h(12)),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.forestGreen : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  mood['emoji']!,
                  style: TextStyle(fontSize: context.w(24)),
                ),
                SizedBox(height: context.h(4)),
                Text(
                  mood['label']!,
                  style: AppTypography.bodySmall(context).copyWith(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
