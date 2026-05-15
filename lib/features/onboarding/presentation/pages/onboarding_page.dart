import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/onboarding_slide_data.dart';
import '../widgets/onboarding_slide.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _slides = kOnboardingSlides;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    HapticFeedback.lightImpact();
    setState(() => _currentPage = index);
  }

  void _goNext() {
    if (_currentPage < _slides.length - 1) {
      HapticFeedback.selectionClick();
      _pageController.nextPage(
        duration: 500.ms,
        curve: Curves.easeInOutCubic,
      );
    } else {
      HapticFeedback.mediumImpact();
      context.go('/welcome');
    }
  }

  void _skip() {
    HapticFeedback.lightImpact();
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _slides.length - 1;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // White status bar icons over dark images
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ── Full-screen paged slides ─────────────────────────────────
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _slides.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return OnboardingSlide(
                  data: _slides[index],
                  isActive: index == _currentPage,
                );
              },
            ),

            // ── Skip button — top right ──────────────────────────────────
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 24,
              child: AnimatedOpacity(
                opacity: isLast ? 0.0 : 1.0,
                duration: 250.ms,
                child: TextButton(
                  onPressed: isLast ? null : _skip,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms),
            ),

            // ── Bottom controls: dots + button ───────────────────────────
            Positioned(
              left: 28,
              right: 28,
              bottom: bottomPadding + 32,
              child: Row(
                children: [
                  // Progress dots
                  Row(
                    children: List.generate(_slides.length, (i) {
                      final isActive = i == _currentPage;
                      return AnimatedContainer(
                        duration: 300.ms,
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.only(right: 6),
                        width: isActive ? 24 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.white
                              : Colors.white.withAlpha(80),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  // Action button
                  GestureDetector(
                    onTap: _goNext,
                    child: AnimatedContainer(
                      duration: 300.ms,
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.forestGreen,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.forestGreen.withAlpha(100),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _slides[_currentPage].buttonLabel,
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
