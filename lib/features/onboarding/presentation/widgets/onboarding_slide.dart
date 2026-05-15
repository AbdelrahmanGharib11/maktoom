import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/onboarding_slide_data.dart';

/// Immersive full-bleed onboarding slide matching the Stitch design:
/// - Full-screen botanical photo background
/// - Dark gradient overlay from bottom
/// - White text anchored to bottom left
/// - Optional small icon badge above headline
class OnboardingSlide extends StatelessWidget {
  final OnboardingSlideData data;
  final bool isActive;

  const OnboardingSlide({
    super.key,
    required this.data,
    // parallaxOffset kept for API compatibility but unused in this layout
    double parallaxOffset = 0,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Full-bleed background image ──────────────────────────────────
        Image.asset(
          data.imagePath,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF1B3A2F),
          ),
        ),

        // ── Multi-stop dark gradient overlay (bottom-heavy) ──────────────
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.35, 0.65, 1.0],
              colors: [
                Color(0x33000000), // very subtle top darkening
                Color(0x00000000), // transparent in the middle
                Color(0xAA000000), // start darkening
                Color(0xEE000000), // heavy dark at bottom
              ],
            ),
          ),
        ),

        // ── Text content anchored to bottom ──────────────────────────────
        Positioned(
          left: 28,
          right: 28,
          bottom: 100, // leaves room for the button/dots row below
          child: _SlideContent(data: data, isActive: isActive),
        ),
      ],
    );
  }
}

class _SlideContent extends StatelessWidget {
  final OnboardingSlideData data;
  final bool isActive;

  const _SlideContent({required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tag pill
        _Staggered(
          delay: 0,
          isActive: isActive,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF2D6A4F).withAlpha(180),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withAlpha(40),
                width: 1,
              ),
            ),
            child: Text(
              data.tag,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Headline
        _Staggered(
          delay: 100,
          isActive: isActive,
          child: Text(
            data.headline,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.15,
              letterSpacing: -0.3,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Body
        _Staggered(
          delay: 200,
          isActive: isActive,
          child: Text(
            data.body,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white.withAlpha(200),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _Staggered extends StatelessWidget {
  final Widget child;
  final int delay;
  final bool isActive;

  const _Staggered({required this.child, required this.delay, required this.isActive});

  @override
  Widget build(BuildContext context) {
    if (!isActive) return child;
    return child
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 550.ms,
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.12,
          end: 0,
          delay: Duration(milliseconds: delay),
          duration: 550.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
