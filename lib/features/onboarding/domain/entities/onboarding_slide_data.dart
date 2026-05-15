

/// Data model for a single onboarding slide.
class OnboardingSlideData {
  final String imagePath;
  final String tag;
  final String headline;
  final String body;
  final String buttonLabel;

  const OnboardingSlideData({
    required this.imagePath,
    required this.tag,
    required this.headline,
    required this.body,
    this.buttonLabel = 'Continue',
  });
}

/// The 3 onboarding slides — immersive full-bleed botanical design.
const kOnboardingSlides = [
  OnboardingSlideData(
    imagePath: 'assets/images/image.png',
    tag: 'YOUR SANCTUARY',
    headline: 'Your identity\nstays yours.',
    body:
        'Maktom is built as a true botanical sanctuary. We prioritize profound privacy, ensuring your journey towards mental wellness is completely anonymous.',
  ),
  OnboardingSlideData(
    imagePath: 'assets/images/rooted_tree.png',
    tag: 'HUMAN CONNECTION',
    headline: 'Expert care,\ndeeply rooted.',
    body:
        'Connect with licensed clinical psychologists and specialists vetted for their expertise and empathy.',
  ),
  OnboardingSlideData(
    imagePath: 'assets/images/leaves_road.png',
    tag: 'YOUR PACE',
    headline: 'Your journey,\nyour pace.',
    body:
        'Book 45 or 60-minute sessions that fit your schedule. Use voice, video, or chat — whatever feels most natural.',
    buttonLabel: 'Get Started',
  ),
];
