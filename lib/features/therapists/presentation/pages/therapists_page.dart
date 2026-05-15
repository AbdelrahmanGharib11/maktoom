import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../domain/entities/therapist_model.dart';
import '../widgets/therapist_card.dart';
import '../widgets/therapist_filter_chip.dart';

class TherapistsPage extends StatefulWidget {
  const TherapistsPage({super.key});

  @override
  State<TherapistsPage> createState() => _TherapistsPageState();
}

class _TherapistsPageState extends State<TherapistsPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSpecialty = 'All';
  String? _selectedLanguage;
  String? _selectedPriceRange;
  String? _selectedAvailability;
  double? _minRating;
  final _scrollController = ScrollController();
  bool _isHeaderCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final collapsed = _scrollController.offset > 60;
      if (collapsed != _isHeaderCollapsed) {
        setState(() => _isHeaderCollapsed = collapsed);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<TherapistModel> get _filteredTherapists {
    return kTherapists.where((t) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!t.name.toLowerCase().contains(q) &&
            !t.title.toLowerCase().contains(q) &&
            !t.specialties.any((s) => s.toLowerCase().contains(q)))
          return false;
      }
      if (_selectedSpecialty != 'All') {
        if (!t.specialties.any(
          (s) => s.toLowerCase() == _selectedSpecialty.toLowerCase(),
        ))
          return false;
      }
      if (_selectedLanguage != null) {
        if (!t.languages.any(
          (l) => l.toLowerCase() == _selectedLanguage!.toLowerCase(),
        ))
          return false;
      }
      if (_selectedPriceRange != null) {
        switch (_selectedPriceRange) {
          case 'Under \$100':
            if (t.pricePerHour >= 100) return false;
          case '\$100 – \$120':
            if (t.pricePerHour < 100 || t.pricePerHour > 120) return false;
          case 'Over \$120':
            if (t.pricePerHour <= 120) return false;
        }
      }
      if (_selectedAvailability != null) {
        if (_selectedAvailability == 'Today' &&
            t.availability != AvailabilityStatus.availableToday)
          return false;
        if (_selectedAvailability == 'Tomorrow' &&
            t.availability != AvailabilityStatus.availableTomorrow)
          return false;
      }
      if (_minRating != null && t.rating < _minRating!) return false;
      return true;
    }).toList();
  }

  bool get _hasActiveFilters =>
      _selectedSpecialty != 'All' ||
      _selectedLanguage != null ||
      _selectedPriceRange != null ||
      _selectedAvailability != null ||
      _minRating != null;

  void _clearAllFilters() => setState(() {
    _selectedSpecialty = 'All';
    _selectedLanguage = null;
    _selectedPriceRange = null;
    _selectedAvailability = null;
    _minRating = null;
  });

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTherapists;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.softOffWhite,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Animated Header ──────────────────────────────────────────
              AnimatedContainer(
                duration: 250.ms,
                padding: EdgeInsets.fromLTRB(
                  context.w(20),
                  _isHeaderCollapsed ? 10 : 20,
                  context.w(20),
                  _isHeaderCollapsed ? 10 : 4,
                ),
                color: AppColors.softOffWhite,
                child: AnimatedCrossFade(
                  duration: 250.ms,
                  crossFadeState: _isHeaderCollapsed
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: _ExpandedHeader(context),
                  secondChild: _CollapsedHeader(context),
                ),
              ),

              // ── Search bar ───────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.w(20),
                  0,
                  context.w(20),
                  12,
                ),
                child: _SearchBar(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

              // ── Filter bar ───────────────────────────────────────────────
              _FilterBar(
                selectedSpecialty: _selectedSpecialty,
                selectedLanguage: _selectedLanguage,
                selectedPriceRange: _selectedPriceRange,
                selectedAvailability: _selectedAvailability,
                minRating: _minRating,
                hasActiveFilters: _hasActiveFilters,
                onSpecialtyChanged: (v) =>
                    setState(() => _selectedSpecialty = v ?? 'All'),
                onLanguageChanged: (v) => setState(() => _selectedLanguage = v),
                onPriceChanged: (v) => setState(() => _selectedPriceRange = v),
                onAvailabilityChanged: (v) =>
                    setState(() => _selectedAvailability = v),
                onRatingChanged: (v) => setState(() => _minRating = v),
                onClearAll: _clearAllFilters,
              ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.05, end: 0),

              const SizedBox(height: 8),

              // ── Therapist list ───────────────────────────────────────────
              Expanded(
                child: filtered.isEmpty
                    ? _EmptyState(
                        query: _searchQuery,
                        filter: _selectedSpecialty,
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.fromLTRB(
                          context.w(20),
                          8,
                          context.w(20),
                          24,
                        ),
                        itemCount: filtered.length + 1, // +1 for concierge card
                        itemBuilder: (context, index) {
                          if (index < filtered.length) {
                            return TherapistCard(
                              therapist: filtered[index],
                              index: index,
                            );
                          }
                          // Match Quiz CTA card at end
                          return _MatchQuizCta()
                              .animate()
                              .fadeIn(
                                delay: Duration(
                                  milliseconds: 60 * filtered.length + 100,
                                ),
                                duration: 400.ms,
                              )
                              .slideY(begin: 0.1, end: 0);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ExpandedHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Verified Experts badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.verified_rounded,
                size: 12,
                color: AppColors.forestGreen,
              ),
              const SizedBox(width: 5),
              Text(
                'VERIFIED EXPERTS',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.forestGreen,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ).animate().fadeIn().slideX(begin: -0.1, end: 0),
        const SizedBox(height: 10),
        Text(
          'Find Your\nSupport',
          style: AppTypography.headingLarge(context).copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.textDark,
            fontSize: 30,
            height: 1.15,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 4),
        Text(
          'Connect with verified professionals in a secure, digital sanctuary.',
          style: AppTypography.bodySmall(
            context,
          ).copyWith(color: AppColors.textMuted, height: 1.5, fontSize: 13),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _CollapsedHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          'Therapists',
          style: AppTypography.headingMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w800, color: AppColors.textDark),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.surfaceGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${kTherapists.length} experts',
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.forestGreen,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Interactive Filter Bar ───────────────────────────────────────────────────

class _FilterBar extends StatefulWidget {
  final String selectedSpecialty;
  final String? selectedLanguage;
  final String? selectedPriceRange;
  final String? selectedAvailability;
  final double? minRating;
  final bool hasActiveFilters;
  final ValueChanged<String?> onSpecialtyChanged;
  final ValueChanged<String?> onLanguageChanged;
  final ValueChanged<String?> onPriceChanged;
  final ValueChanged<String?> onAvailabilityChanged;
  final ValueChanged<double?> onRatingChanged;
  final VoidCallback onClearAll;

  const _FilterBar({
    required this.selectedSpecialty,
    required this.selectedLanguage,
    required this.selectedPriceRange,
    required this.selectedAvailability,
    required this.minRating,
    required this.hasActiveFilters,
    required this.onSpecialtyChanged,
    required this.onLanguageChanged,
    required this.onPriceChanged,
    required this.onAvailabilityChanged,
    required this.onRatingChanged,
    required this.onClearAll,
  });

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  bool _moreFiltersExpanded = false;

  // Derived lists from mock data
  static final _allSpecialties = {
    'All',
    ...kTherapists.expand((t) => t.specialties),
  }.toList();

  static final _allLanguages =
      kTherapists.expand((t) => t.languages).toSet().toList()..sort();

  static const _priceRanges = ['Under \$100', '\$100 – \$120', 'Over \$120'];
  static const _availabilities = ['Today', 'Tomorrow'];
  static const _ratingOptions = [4.5, 4.7, 4.9];

  Widget _chip({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    IconData? icon,
    bool hasDropdown = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.forestGreen : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive
                ? AppColors.forestGreen
                : AppColors.forestGreen.withAlpha(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 15,
                color: isActive
                    ? const Color(0xFFC2E8D3)
                    : AppColors.forestGreen,
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : AppColors.textDark,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 3),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: isActive ? const Color(0xFFC2E8D3) : AppColors.textMuted,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSpecialtyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _PickerSheet(
        title: 'Specialty',
        options: _allSpecialties,
        selected: widget.selectedSpecialty,
        onSelected: (v) {
          widget.onSpecialtyChanged(v);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _PickerSheet(
        title: 'Language',
        options: ['Any', ..._allLanguages],
        selected: widget.selectedLanguage ?? 'Any',
        onSelected: (v) {
          widget.onLanguageChanged(v == 'Any' ? null : v);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showPricePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _PickerSheet(
        title: 'Price Range',
        options: ['Any Price', ..._priceRanges],
        selected: widget.selectedPriceRange ?? 'Any Price',
        onSelected: (v) {
          widget.onPriceChanged(v == 'Any Price' ? null : v);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final specialtyLabel = widget.selectedSpecialty == 'All'
        ? 'Specialty'
        : 'Specialty: ${widget.selectedSpecialty}';
    final languageLabel = widget.selectedLanguage == null
        ? 'Language'
        : 'Lang: ${widget.selectedLanguage}';
    final priceLabel = widget.selectedPriceRange ?? 'Price';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Row 1: Main chips ─────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip(
                label: specialtyLabel,
                isActive: widget.selectedSpecialty != 'All',
                icon: Icons.psychology_outlined,
                hasDropdown: true,
                onTap: _showSpecialtyPicker,
              ),
              _chip(
                label: languageLabel,
                isActive: widget.selectedLanguage != null,
                icon: Icons.language_rounded,
                hasDropdown: true,
                onTap: _showLanguagePicker,
              ),
              _chip(
                label: priceLabel,
                isActive: widget.selectedPriceRange != null,
                icon: Icons.payments_outlined,
                hasDropdown: true,
                onTap: _showPricePicker,
              ),
              _chip(
                label: 'More Filters',
                isActive:
                    _moreFiltersExpanded ||
                    widget.selectedAvailability != null ||
                    widget.minRating != null,
                icon: Icons.tune_rounded,
                onTap: () => setState(
                  () => _moreFiltersExpanded = !_moreFiltersExpanded,
                ),
              ),
              if (widget.hasActiveFilters)
                GestureDetector(
                  onTap: widget.onClearAll,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDED),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFFFB3B3).withAlpha(150),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.close_rounded,
                          size: 14,
                          color: Color(0xFFD90429),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Clear',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD90429),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        // ── Row 2: Expanded more filters ─────────────────────────────
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: _moreFiltersExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // Availability chips
                ..._availabilities.map(
                  (a) => _chip(
                    label: a,
                    isActive: widget.selectedAvailability == a,
                    icon: a == 'Today'
                        ? Icons.today_rounded
                        : Icons.event_rounded,
                    onTap: () => widget.onAvailabilityChanged(
                      widget.selectedAvailability == a ? null : a,
                    ),
                  ),
                ),
                // Rating chips
                ..._ratingOptions.map(
                  (r) => _chip(
                    label: '${r}+ ★',
                    isActive: widget.minRating == r,
                    icon: Icons.star_rounded,
                    onTap: () => widget.onRatingChanged(
                      widget.minRating == r ? null : r,
                    ),
                  ),
                ),
              ],
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

// ─── Picker Bottom Sheet ──────────────────────────────────────────────────────

class _PickerSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  const _PickerSheet({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.65;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF7FBF8), // very light green-tinted white
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Handle + header ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textMuted.withAlpha(50),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.filter_list_rounded,
                          size: 18,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${options.length} options',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted.withAlpha(160),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    height: 1,
                    color: AppColors.forestGreen.withAlpha(15),
                  ),
                ],
              ),
            ),

            // ── Options list ───────────────────────────────────────────
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                itemCount: options.length,
                itemBuilder: (context, i) {
                  final opt = options[i];
                  final isSelected = opt == selected;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onSelected(opt),
                        borderRadius: BorderRadius.circular(14),
                        splashColor: AppColors.forestGreen.withAlpha(20),
                        highlightColor: AppColors.forestGreen.withAlpha(10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.forestGreen.withAlpha(12)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.forestGreen.withAlpha(80)
                                  : const Color(0xFFE8F0EB),
                              width: isSelected ? 1.5 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.forestGreen.withAlpha(
                                        15,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(6),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                          ),
                          child: Row(
                            children: [
                              // ── Left accent dot ──────────────────────
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColors.forestGreen
                                      : const Color(0xFFDDE8E2),
                                ),
                              ),
                              const SizedBox(width: 14),
                              // ── Label ───────────────────────────────
                              Expanded(
                                child: Text(
                                  opt,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 15,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.forestGreen
                                        : AppColors.textDark,
                                  ),
                                ),
                              ),
                              // ── Checkmark ───────────────────────────
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: isSelected
                                    ? Container(
                                        key: const ValueKey('check'),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppColors.forestGreen,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_rounded,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const SizedBox(
                                        key: ValueKey('empty'),
                                        width: 20,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 12),
          ],
        ),
      ),
    );
  }
}

// ─── Search Bar ───────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withAlpha(10),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: AppColors.forestGreen,
        style: AppTypography.bodyMedium(
          context,
        ).copyWith(color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'Search by name or specialty…',
          hintStyle: AppTypography.bodyMedium(
            context,
          ).copyWith(color: AppColors.textMuted.withAlpha(140), fontSize: 14),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 20,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.textMuted,
                  size: 18,
                ),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              );
            },
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE0EDE4), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.forestGreen,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Match Quiz CTA ────────────────────────────────────────────────────────────

class _MatchQuizCta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Not sure who to choose?",
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Take our quick match quiz to find the right therapist for you.',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: Colors.white.withAlpha(200),
                    height: 1.5,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.push('/app/therapists/quiz');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.forestGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Take the Quiz',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.psychology_outlined,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final String query;
  final String filter;

  const _EmptyState({required this.query, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppColors.forestGreen,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No therapists found',
            style: AppTypography.headingMedium(
              context,
            ).copyWith(color: AppColors.textDark, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different search or filter',
            style: AppTypography.bodyMedium(
              context,
            ).copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
