import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../domain/entities/therapist_model.dart';

class QuizResultsPage extends StatelessWidget {
  const QuizResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, these would be fetched dynamically based on quiz answers.
    final topMatches = kTherapists.take(3).toList();
    
    final matchPercentages = [98, 92, 89];
    final matchReasons = [
      "Dr. Jenkins excels in cognitive behavioral therapy with a focus on mindfulness, perfectly aligning with your request for practical, structured coping strategies. Her warm, conversational style matches your preference for an interactive dialogue.",
      "Marcus brings a gentle, empathetic approach to life transitions. His use of Acceptance and Commitment Therapy (ACT) aligns closely with your goal of finding deeper meaning and navigating current life changes.",
      "Elena's focus on solution-oriented therapy and relationship dynamics is a strong fit for your current stress points. She offers actionable insights in a supportive environment."
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF1), // surface-bright
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF0F5238)),
          onPressed: () {},
        ),
        title: Text(
          'Maktom',
          style: TextStyle(
            color: const Color(0xFF0F5238),
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.maps_home_work_outlined, color: Color(0xFF0F5238)),
            onPressed: () => context.go('/app/home'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.h(24)),
                  Text(
                    'THERAPIST MATCH QUIZ RESULTS',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF006C48), // secondary
                      letterSpacing: 1.5,
                    ),
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),
                  SizedBox(height: context.h(12)),
                  Text(
                    "Your top matches",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1C17), // on-surface
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      letterSpacing: -0.02,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                  SizedBox(height: context.h(16)),
                  Text(
                    "Based on your responses, we've found therapists who specialize in your specific needs and align with your preferred communication style.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF404943), // on-surface-variant
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                  SizedBox(height: context.h(32)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.w(24)),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _MatchResultCard(
                      therapist: topMatches[index],
                      matchPercentage: matchPercentages[index],
                      reason: matchReasons[index],
                      isTopMatch: index == 0,
                      isSecondaryAction: index == 2,
                    ).animate().fadeIn(delay: Duration(milliseconds: 400 + (100 * index))).slideY(begin: 0.1, end: 0),
                  );
                },
                childCount: topMatches.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: context.h(48)),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // Go back to quiz
                    context.go('/app/therapists/quiz');
                  },
                  child: Text(
                    'Retake Match Quiz',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F5238),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchResultCard extends StatefulWidget {
  final TherapistModel therapist;
  final int matchPercentage;
  final String reason;
  final bool isTopMatch;
  final bool isSecondaryAction;

  const _MatchResultCard({
    required this.therapist,
    required this.matchPercentage,
    required this.reason,
    required this.isTopMatch,
    this.isSecondaryAction = false,
  });

  @override
  State<_MatchResultCard> createState() => _MatchResultCardState();
}

class _MatchResultCardState extends State<_MatchResultCard> {
  bool _isReasonExpanded = false;

  @override
  void initState() {
    super.initState();
    if (widget.isTopMatch) {
      _isReasonExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // surface-container-lowest
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4EB)), // surface-container-low
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F5238).withAlpha(20),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: widget.therapist.avatarBgColor,
                  child: Image.asset(
                    'assets/images/therapist_1.png', // Fallback, normally would use therapist image URL
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_rounded,
                      size: 64,
                      color: AppColors.forestGreen.withAlpha(160),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Match Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF92F7C3).withAlpha(128), // secondary-container / 50
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isTopMatch) ...[
                    const Icon(Icons.star_rounded, size: 16, color: Color(0xFF00734D)),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    '${widget.matchPercentage}% Match',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00734D), // on-secondary-container
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Name and Title
            Text(
              widget.therapist.name,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1C17), // on-surface
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.therapist.title} · ${widget.therapist.reviewCount ~/ 10} yrs exp', // Mocking experience from reviewCount
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: const Color(0xFF404943), // on-surface-variant
              ),
            ),
            const SizedBox(height: 16),
            
            // Specialties
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.therapist.specialties.take(3).map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E3DA), // surface-variant
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    s,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF404943), // on-surface-variant
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            // Why this match box
            GestureDetector(
              onTap: () {
                setState(() {
                  _isReasonExpanded = !_isReasonExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4EB), // surface-container-low
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.psychology_outlined, size: 20, color: Color(0xFF0F5238)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Why this match?',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1C17),
                            ),
                          ),
                        ),
                        Icon(
                          _isReasonExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          size: 20,
                          color: const Color(0xFF404943),
                        ),
                      ],
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox(width: double.infinity, height: 0),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          const Divider(color: Color(0xFFD9DBD2), height: 1), // surface-dim
                          const SizedBox(height: 12),
                          Text(
                            widget.reason,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 14,
                              height: 1.5,
                              color: const Color(0xFF404943),
                            ),
                          ),
                        ],
                      ),
                      crossFadeState: _isReasonExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.push('/app/therapists/${widget.therapist.id}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isSecondaryAction ? Colors.transparent : const Color(0xFF0F5238), // primary
                      foregroundColor: widget.isSecondaryAction ? const Color(0xFF0F5238) : Colors.white,
                      elevation: widget.isSecondaryAction ? 0 : 4,
                      shadowColor: const Color(0xFF0F5238).withAlpha(50),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: widget.isSecondaryAction 
                            ? BorderSide(color: const Color(0xFF707973)) // outline
                            : BorderSide.none,
                      ),
                    ),
                    child: Text(
                      widget.isSecondaryAction ? 'View Profile' : 'Book Consultation',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEFE6), // surface-container
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFBFC9C1)), // outline-variant
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border_rounded, color: Color(0xFF0F5238)),
                    onPressed: () {},
                    tooltip: 'Save Profile',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
