import 'dart:io';
import 'dart:ui';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/therapist_model.dart';

/// Voice Preview (Immersive Redesign)
///
/// Full-bleed blurred botanical background, glassmorphism card,
/// and a REAL audio waveform extracted from the therapist's voice file
/// using the [audio_waveforms] package.
class VoicePreviewPage extends StatefulWidget {
  final String therapistId;

  const VoicePreviewPage({super.key, required this.therapistId});

  @override
  State<VoicePreviewPage> createState() => _VoicePreviewPageState();
}

class _VoicePreviewPageState extends State<VoicePreviewPage>
    with SingleTickerProviderStateMixin {
  // ── audio_waveforms controller ─────────────────────────────────────────────
  late final PlayerController _playerController;

  // ── UI state ───────────────────────────────────────────────────────────────
  bool _isReady = false;
  bool _isPlaying = false;
  bool _hasError = false;
  String _errorMessage = '';

  // Avatar breathing animation
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  // ── resolved therapist ────────────────────────────────────────────────────
  TherapistModel get _therapist =>
      kTherapists.firstWhere(
        (t) => t.id == widget.therapistId,
        orElse: () => kTherapists.first,
      );

  @override
  void initState() {
    super.initState();

    _playerController = PlayerController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initAudio();
    _listenToPlayerState();
  }

  // ── Copy asset → temp file, then prepare the player ──────────────────────

  Future<void> _initAudio() async {
    try {
      // 1. Load the raw bytes from the Flutter asset bundle
      final ByteData data =
          await rootBundle.load(_therapist.voiceIntroAssetPath);
      final Uint8List bytes = data.buffer.asUint8List();

      // 2. Write to a platform-accessible temp file
      final Directory dir = await getTemporaryDirectory();
      final String fileName =
          '${_therapist.id}_intro.mp3';
      final File tempFile = File('${dir.path}/$fileName');
      await tempFile.writeAsBytes(bytes, flush: true);

      // 3. Prepare the player — this is where the real waveform is extracted
      await _playerController.preparePlayer(
        path: tempFile.path,
        shouldExtractWaveform: true,
        noOfSamples: 100, // number of amplitude samples for the waveform
        volume: 1.0,
      );

      if (mounted) setState(() => _isReady = true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  // ── React to native player events (play / pause / stop / finish) ──────────

  void _listenToPlayerState() {
    _playerController.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      final playing = state == PlayerState.playing;
      setState(() => _isPlaying = playing);
      if (playing) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.animateTo(0);
      }
    });
  }

  // ── Playback controls ─────────────────────────────────────────────────────

  Future<void> _togglePlayback() async {
    HapticFeedback.mediumImpact();
    if (!_isReady) return;
    if (_isPlaying) {
      await _playerController.pausePlayer();
    } else {
      await _playerController.startPlayer();
    }
  }

  Future<void> _seek(Duration delta) async {
    if (!_isReady) return;
    HapticFeedback.selectionClick();
    final current = await _playerController.getDuration(DurationType.current);
    final total = await _playerController.getDuration(DurationType.max);
    if (current == null || total == null) return;
    final newMs = (current + delta.inMilliseconds).clamp(0, total);
    await _playerController.seekTo(newMs);
  }

  @override
  void dispose() {
    _playerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // ── 1. Full-bleed blurred botanical background ────────────────
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Image.asset(
                'assets/images/opening_flower.png',
                fit: BoxFit.cover,
              ),
            ),

            // ── 2. Dark overlay ──────────────────────────────────────────
            Container(color: Colors.black.withAlpha(110)),

            // ── 3. Content ───────────────────────────────────────────────
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenW * 0.055,
                    vertical: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(26),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withAlpha(50),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _CardHeader(onClose: () {
                              if (context.canPop()) context.pop();
                            }),
                            const SizedBox(height: 24),
                            _TherapistAvatar(
                              pulseAnimation: _pulseAnimation,
                              size: screenW * 0.30,
                            ),
                            const SizedBox(height: 20),
                            _TherapistInfo(therapist: _therapist),
                            const SizedBox(height: 28),

                            // ── Real audio waveform ──────────────────────
                            if (_isReady)
                              _RealWaveform(controller: _playerController)
                            else if (_hasError)
                              _ErrorState(message: _errorMessage)
                            else
                              _LoadingWaveform(),

                            const SizedBox(height: 24),

                            // ── Playback controls ────────────────────────
                            _PlaybackControls(
                              isPlaying: _isPlaying,
                              isReady: _isReady,
                              onToggle: _togglePlayback,
                              onRewind: () => _seek(const Duration(seconds: -10)),
                              onForward: () => _seek(const Duration(seconds: 10)),
                            ),

                            const SizedBox(height: 28),

                            _BookButton(onTap: () {
                              context.push(
                                  '/app/therapists/${widget.therapistId}/book');
                            }),

                            const SizedBox(height: 16),
                            _EncryptedBadge(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Card Header ──────────────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  final VoidCallback onClose;
  const _CardHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Voice Introduction',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withAlpha(60), width: 1),
            ),
            child:
                const Icon(Icons.close_rounded, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}

// ─── Therapist Avatar ─────────────────────────────────────────────────────────

class _TherapistAvatar extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final double size;

  const _TherapistAvatar({
    required this.pulseAnimation,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: pulseAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: size + 24,
            height: size + 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withAlpha(40),
                width: 1.5,
              ),
            ),
          ),
          // Inner ring
          Container(
            width: size + 8,
            height: size + 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Colors.white.withAlpha(160), width: 2),
            ),
          ),
          // Avatar
          Container(
            width: size,
            height: size,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2D6A4F),
            ),
            child: Image.asset(
              'assets/images/therapist_1.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.person_rounded,
                color: Colors.white70,
                size: 56,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

// ─── Therapist Info ───────────────────────────────────────────────────────────

class _TherapistInfo extends StatelessWidget {
  final TherapistModel therapist;
  const _TherapistInfo({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          therapist.name,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          therapist.title,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF95D4B3),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: therapist.specialties.take(3).map((chip) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: Colors.white.withAlpha(60), width: 1),
              ),
              child: Text(
                chip,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }
}

// ─── Real Waveform (audio_waveforms) ─────────────────────────────────────────

class _RealWaveform extends StatelessWidget {
  final PlayerController controller;
  const _RealWaveform({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AudioFileWaveforms(
      playerController: controller,
      size: Size(MediaQuery.of(context).size.width - 110, 80),
      waveformType: WaveformType.long,
      playerWaveStyle: const PlayerWaveStyle(
        // Played portion — forest green
        fixedWaveColor: Color(0xFF2D6A4F),
        // Unplayed portion — semi-transparent white
        liveWaveColor: Colors.white54,
        // Seek position line — gold
        seekLineColor: Color(0xFFD4A843),
        seekLineThickness: 2,
        waveThickness: 2.5,
        showSeekLine: true,
        waveCap: StrokeCap.round,
        scaleFactor: 150,
      ),
      enableSeekGesture: true, // tap/drag to seek
    );
  }
}

// ─── Loading Waveform Skeleton ────────────────────────────────────────────────

class _LoadingWaveform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white.withAlpha(180),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Extracting waveform…',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              color: Colors.white.withAlpha(150),
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Text(
          'Could not load audio.\n$message',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12,
            color: Colors.red.withAlpha(200),
          ),
        ),
      ),
    );
  }
}

// ─── Playback Controls ────────────────────────────────────────────────────────

class _PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final bool isReady;
  final VoidCallback onToggle;
  final VoidCallback onRewind;
  final VoidCallback onForward;

  const _PlaybackControls({
    required this.isPlaying,
    required this.isReady,
    required this.onToggle,
    required this.onRewind,
    required this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SkipButton(
          icon: Icons.replay_10_rounded,
          enabled: isReady,
          onTap: onRewind,
        ),
        const SizedBox(width: 28),

        // Play / Pause button
        GestureDetector(
          onTap: isReady ? onToggle : null,
          child: AnimatedContainer(
            duration: 250.ms,
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: isReady
                  ? const Color(0xFF2D6A4F)
                  : Colors.white.withAlpha(40),
              shape: BoxShape.circle,
              boxShadow: isReady
                  ? [
                      BoxShadow(
                        color: const Color(0xFF2D6A4F).withAlpha(120),
                        blurRadius: 24,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: isReady
                ? Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 36,
                  )
                : const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white54,
                    ),
                  ),
          ),
        ),

        const SizedBox(width: 28),
        _SkipButton(
          icon: Icons.forward_10_rounded,
          enabled: isReady,
          onTap: onForward,
        ),
      ],
    );
  }
}

class _SkipButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _SkipButton(
      {required this.icon, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(enabled ? 30 : 15),
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white.withAlpha(enabled ? 60 : 30), width: 1),
        ),
        child: Icon(icon,
            color: enabled ? Colors.white : Colors.white38, size: 24),
      ),
    );
  }
}

// ─── Book Button ──────────────────────────────────────────────────────────────

class _BookButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BookButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text(
          'Book a Session',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ─── Encrypted Badge ──────────────────────────────────────────────────────────

class _EncryptedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(40), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_rounded, color: Colors.white70, size: 13),
          const SizedBox(width: 6),
          Text(
            'End-to-End Encrypted',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}
