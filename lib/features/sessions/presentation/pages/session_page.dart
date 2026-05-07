import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.calmingGradient,
              ),
            ),
          ),
          
          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.textDark),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '24:15',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Center Avatar & Animation
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pulsing Ring
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.warmSage.withOpacity(0.2),
                      ),
                    ).animate(onPlay: (controller) => controller.repeat())
                     .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 2.seconds)
                     .fadeOut(duration: 2.seconds),
                    
                    // Avatar
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: AppColors.surfaceGreen,
                        child: Icon(Icons.psychology, size: 60, color: AppColors.forestGreen),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Dr. Sarah Ahmed',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Speaking...',
                  style: TextStyle(color: AppColors.warmSage, fontWeight: FontWeight.w600),
                ).animate(onPlay: (controller) => controller.repeat())
                 .fadeIn(duration: 1.seconds).fadeOut(delay: 1.seconds),
              ],
            ),
          ),
          
          // Floating Notes Button
          Positioned(
            right: 20,
            bottom: 120,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 2,
              child: const Icon(Icons.note_alt_outlined, color: AppColors.forestGreen),
            ),
          ).animate().fadeIn(delay: 1000.ms),
          
          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildControlButton(Icons.videocam_off_outlined, false),
                  const SizedBox(width: 24),
                  _buildControlButton(Icons.mic_none_outlined, false),
                  const SizedBox(width: 24),
                  _buildControlButton(Icons.call_end, true),
                ],
              ),
            ),
          ).animate().slideY(begin: 0.5, end: 0, delay: 500.ms),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, bool isEnd) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isEnd ? const Color(0xFFE57373) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Icon(icon, color: isEnd ? Colors.white : AppColors.textDark),
    );
  }
}
