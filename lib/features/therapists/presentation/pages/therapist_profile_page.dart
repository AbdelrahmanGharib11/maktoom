import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/therapist_model.dart';

class TherapistProfilePage extends StatefulWidget {
  final String therapistId;

  const TherapistProfilePage({super.key, required this.therapistId});

  @override
  State<TherapistProfilePage> createState() => _TherapistProfilePageState();
}

class _TherapistProfilePageState extends State<TherapistProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  bool _isScrolled = false;

  TherapistModel get _therapist => kTherapists.firstWhere(
    (t) => t.id == widget.therapistId,
    orElse: () => kTherapists.first,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 50 && !_isScrolled) {
          setState(() => _isScrolled = true);
        } else if (_scrollController.offset <= 50 && _isScrolled) {
          setState(() => _isScrolled = false);
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 320,
                  pinned: true,
                  backgroundColor: AppColors.background,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  leading: _buildAppBarButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => context.pop(),
                  ),
                  actions: [
                    _buildAppBarButton(
                      icon: Icons.ios_share_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: _ProfileHero(therapist: _therapist),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: AppColors.forestGreen,
                      unselectedLabelColor: AppColors.textMuted,
                      indicatorColor: AppColors.forestGreen,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _AboutTab(therapist: _therapist),
                _ReviewsTab(therapist: _therapist),
              ],
            ),
          ),
          // Bottom CTA
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomCtaBar(therapist: _therapist),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Center(
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.forestGreen.withAlpha(20),
                width: 1,
              ),
            ),
            child: Icon(icon, color: AppColors.forestGreen, size: 20),
          ),
        ),
      ),
    ).animate().fadeIn();
  }
}

class _ProfileHero extends StatelessWidget {
  final TherapistModel therapist;

  const _ProfileHero({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [therapist.avatarBgColor, AppColors.background],
                stops: const [0.0, 0.8],
              ),
            ),
          ),
        ),
        // Content
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Avatar with online status
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      // border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.forestGreen.withAlpha(20),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      'assets/images/therapist_1.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.person_rounded,
                        color: AppColors.forestGreen.withAlpha(100),
                        size: 60,
                      ),
                    ),
                  ),
                  if (therapist.availability ==
                      AvailabilityStatus.availableToday)
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                ],
              ).animate().scale(
                duration: 500.ms,
                curve: Curves.easeOutBack,
                begin: const Offset(0.8, 0.8),
              ),
              const SizedBox(height: 16),
              // Name and Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    therapist.name,
                    style: AppTypography.headingLarge(context).copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.verified_rounded,
                    color: Color(0xFF3B82F6),
                    size: 20,
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 4),
              Text(
                therapist.title,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: AppColors.forestGreen,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(
                    icon: Icons.star_rounded,
                    iconColor: AppColors.mutedGold,
                    value: '${therapist.rating}',
                    label: '${therapist.reviewCount} reviews',
                  ),
                  _StatDivider(),
                  const _StatItem(
                    icon: Icons.calendar_month_rounded,
                    iconColor: AppColors.warmSage,
                    value: '1.2k+',
                    label: 'Sessions',
                  ),
                  _StatDivider(),
                  const _StatItem(
                    icon: Icons.workspace_premium_rounded,
                    iconColor: Color(0xFF8B5CF6),
                    value: '8 yrs',
                    label: 'Experience',
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 4),
            Text(
              value,
              style: AppTypography.bodyLarge(context).copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.bodySmall(
            context,
          ).copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: AppColors.forestGreen.withAlpha(20),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.background, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// ─── About Tab ──────────────────────────────────────────────────────────────

class _AboutTab extends StatelessWidget {
  final TherapistModel therapist;

  const _AboutTab({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120), // Padding for CTA
      children: [
        _SectionTitle(title: 'About'),
        const SizedBox(height: 12),
        Text(
          therapist.bio,
          style: AppTypography.bodyMedium(
            context,
          ).copyWith(color: AppColors.textMuted, height: 1.6),
        ),
        const SizedBox(height: 32),
        _SectionTitle(title: 'Specialties'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: therapist.specialties.map((s) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.forestGreen.withAlpha(20)),
              ),
              child: Text(
                s,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.forestGreen,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        _SectionTitle(title: 'Languages'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: therapist.languages.map((l) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceGreen.withAlpha(100),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.language_rounded,
                    size: 16,
                    color: AppColors.forestGreen,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }
}

// ─── Reviews Tab ────────────────────────────────────────────────────────────

class _ReviewsTab extends StatelessWidget {
  final TherapistModel therapist;

  const _ReviewsTab({required this.therapist});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'name': 'S.M.',
        'text':
            'Dr. Thorne genuinely helped me find quiet in the chaos. Her mindfulness exercises are practical and easy to weave into my busy days.',
        'rating': 5,
        'date': '2 days ago',
      },
      {
        'name': 'Anonymous',
        'text':
            'The most judgment-free environment I\'ve ever experienced. I felt heard immediately, and the grounding techniques actually work.',
        'rating': 5,
        'date': '1 week ago',
      },
      {
        'name': 'J.D.',
        'text':
            'I appreciate her warm approach. It doesn\'t feel clinical at all; it feels like stepping into a safe sanctuary.',
        'rating': 4,
        'date': '2 weeks ago',
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final r = reviews[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.forestGreen.withAlpha(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.surfaceGreen,
                    child: Text(
                      (r['name'] as String).substring(0, 1),
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.forestGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    r['name'] as String,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    r['date'] as String,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: i < (r['rating'] as int)
                        ? AppColors.mutedGold
                        : AppColors.forestGreen.withAlpha(20),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                r['text'] as String,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1, end: 0);
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.headingMedium(
        context,
      ).copyWith(fontWeight: FontWeight.w800, color: AppColors.textDark),
    );
  }
}

// ─── Bottom CTA Bar ──────────────────────────────────────────────────────────

class _BottomCtaBar extends StatelessWidget {
  final TherapistModel therapist;

  const _BottomCtaBar({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFF1A2E25,
        ), // dark panel matching the design screenshot
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Voice Preview icon button ────────────────────────────────
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () =>
                  context.push('/app/therapists/${therapist.id}/voice-preview'),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.surfaceGreen,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: AppColors.forestGreen,
                  size: 26,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // ── Book Session button ──────────────────────────────────────
          Expanded(
            child: ElevatedButton(
              onPressed: () =>
                  context.push('/app/therapists/${therapist.id}/book'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forestGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Book Session',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(
      begin: 1,
      end: 0,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    );
  }
}
