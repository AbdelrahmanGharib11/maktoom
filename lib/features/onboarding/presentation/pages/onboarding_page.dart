import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/maktom_button.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../widgets/onboarding_item_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingEntity> _items = [
    const OnboardingEntity(
      title: 'Private & Safe',
      description: 'A quiet private room where you can finally exhale without judgment.',
      imagePath: 'assets/images/onboarding_1.png',
    ),
    const OnboardingEntity(
      title: 'Total Anonymity',
      description: 'Your identity stays yours. Connect with others safely and anonymously.',
      imagePath: 'assets/images/onboarding_2.png',
    ),
    const OnboardingEntity(
      title: 'Professional Support',
      description: 'Expert therapists available whenever you need a listening ear.',
      imagePath: 'assets/images/splash_bg.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(item: _items[index]);
                },
              ),
            ),
            
            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: 300.ms,
                  margin: EdgeInsets.symmetric(horizontal: context.w(4)),
                  height: context.h(8),
                  width: _currentPage == index ? context.w(24) : context.w(8),
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.forestGreen : AppColors.warmSage.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(context.w(40)),
              child: Column(
                children: [
                  MaktomButton(
                    text: _currentPage == _items.length - 1 ? context.l10n.getStarted : context.l10n.next,
                    onPressed: () {
                      if (_currentPage < _items.length - 1) {
                        _pageController.nextPage(
                          duration: 500.ms,
                          curve: Curves.easeInOut,
                        );
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                  
                  if (_currentPage < _items.length - 1)
                    TextButton(
                      onPressed: () => context.go('/'),
                      child: Text(
                        context.l10n.skip,
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
