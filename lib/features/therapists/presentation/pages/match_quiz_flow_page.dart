import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';

class MatchQuizFlowPage extends StatefulWidget {
  const MatchQuizFlowPage({super.key});

  @override
  State<MatchQuizFlowPage> createState() => _MatchQuizFlowPageState();
}

class _MatchQuizFlowPageState extends State<MatchQuizFlowPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Quiz State
  String? _q1Answer;
  final List<String> _q2Answers = [];
  String? _q3Answer;

  bool get _canContinue {
    switch (_currentPage) {
      case 0:
        return _q1Answer != null;
      case 1:
        return _q2Answers.isNotEmpty;
      case 2:
        return _q3Answer != null;
      default:
        return false;
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to results page with quiz parameters.
      // In a real app we would pass the answers as state or query params.
      context.go('/app/therapists/quiz/results');
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F0), // Off-White
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1B4332)),
          onPressed: _previousPage,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final isActive = index <= _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF2D6A4F) : const Color(0xFFD8E2DC),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: [
                _buildQ1(),
                _buildQ2(),
                _buildQ3(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildQ1() {
    final options = [
      {'title': 'Anxiety & Stress', 'icon': Icons.water_drop_outlined},
      {'title': 'Depression', 'icon': Icons.nights_stay_outlined},
      {'title': 'Relationship Issues', 'icon': Icons.favorite_border_rounded},
      {'title': 'Life Transitions', 'icon': Icons.explore_outlined},
      {'title': 'Self-Esteem', 'icon': Icons.star_border_rounded},
      {'title': 'Trauma', 'icon': Icons.healing_outlined},
    ];

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: context.w(24), vertical: context.h(24)),
      children: [
        Text(
          "What's on your mind most?",
          style: TextStyle(
            color: const Color(0xFF1B4332), // Forest Green
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: context.h(12)),
        Text(
          "Select the area that feels most present for you right now.",
          style: TextStyle(
            color: const Color(0xFF40916C), // Sage
            fontFamily: 'Manrope',
            fontSize: 16,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: context.h(32)),
        ...options.asMap().entries.map((entry) {
          final i = entry.key;
          final opt = entry.value;
          final isSelected = _q1Answer == opt['title'];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOptionCard(
              title: opt['title'] as String,
              icon: opt['icon'] as IconData,
              isSelected: isSelected,
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _q1Answer = opt['title'] as String);
              },
            ),
          ).animate().fadeIn(delay: (300 + (i * 50)).ms).slideX(begin: 0.05, end: 0);
        }),
      ],
    );
  }

  Widget _buildQ2() {
    final options = [
      {'title': 'Empathic & Warm', 'icon': Icons.wb_sunny_outlined},
      {'title': 'Direct & Solution-Focused', 'icon': Icons.arrow_forward_rounded},
      {'title': 'LGBTQ+ Affirming', 'icon': Icons.diversity_3_rounded},
      {'title': 'Faith-Based', 'icon': Icons.church_outlined},
      {'title': 'Holistic / Mindfulness', 'icon': Icons.spa_outlined},
    ];

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: context.w(24), vertical: context.h(24)),
      children: [
        Text(
          "What qualities do you value?",
          style: TextStyle(
            color: const Color(0xFF1B4332),
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: context.h(12)),
        Text(
          "Select all that apply to help us find the right match.",
          style: TextStyle(
            color: const Color(0xFF40916C),
            fontFamily: 'Manrope',
            fontSize: 16,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: context.h(32)),
        ...options.asMap().entries.map((entry) {
          final i = entry.key;
          final opt = entry.value;
          final isSelected = _q2Answers.contains(opt['title']);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOptionCard(
              title: opt['title'] as String,
              icon: opt['icon'] as IconData,
              isSelected: isSelected,
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() {
                  if (isSelected) {
                    _q2Answers.remove(opt['title']);
                  } else {
                    _q2Answers.add(opt['title'] as String);
                  }
                });
              },
            ),
          ).animate().fadeIn(delay: (300 + (i * 50)).ms).slideX(begin: 0.05, end: 0);
        }),
      ],
    );
  }

  Widget _buildQ3() {
    final options = [
      {'title': 'Video Sessions', 'desc': 'Face-to-face interaction', 'icon': Icons.videocam_outlined},
      {'title': 'Audio Only', 'desc': 'Voice calls with your therapist', 'icon': Icons.mic_none_rounded},
      {'title': 'Text & Messaging', 'desc': 'Chat asynchronously', 'icon': Icons.chat_bubble_outline_rounded},
    ];

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: context.w(24), vertical: context.h(24)),
      children: [
        Text(
          "How do you prefer to connect?",
          style: TextStyle(
            color: const Color(0xFF1B4332),
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: context.h(12)),
        Text(
          "Choose the format that feels most comfortable for you.",
          style: TextStyle(
            color: const Color(0xFF40916C),
            fontFamily: 'Manrope',
            fontSize: 16,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: context.h(32)),
        ...options.asMap().entries.map((entry) {
          final i = entry.key;
          final opt = entry.value;
          final isSelected = _q3Answer == opt['title'];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOptionCard(
              title: opt['title'] as String,
              subtitle: opt['desc'] as String,
              icon: opt['icon'] as IconData,
              isSelected: isSelected,
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _q3Answer = opt['title'] as String);
              },
            ),
          ).animate().fadeIn(delay: (300 + (i * 50)).ms).slideX(begin: 0.05, end: 0);
        }),
      ],
    );
  }

  Widget _buildOptionCard({
    required String title,
    String? subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F3ED) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF52B788) : const Color(0xFFD8E2DC),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF52B788).withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF52B788) : const Color(0xFFF8F9F0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF2D6A4F),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF1B4332),
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF708D81),
                        fontFamily: 'Manrope',
                        fontSize: 13,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF52B788), size: 24)
                .animate().scale(duration: 200.ms, curve: Curves.easeOutBack)
            else
              const Icon(Icons.radio_button_unchecked_rounded, color: Color(0xFFD8E2DC), size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFD8E2DC).withOpacity(0.5))),
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _canContinue ? 1.0 : 0.5,
        child: FilledButton(
          onPressed: _canContinue ? _nextPage : null,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF2D6A4F),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            _currentPage == 2 ? 'See My Matches' : 'Continue',
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
