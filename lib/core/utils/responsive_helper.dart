import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Scaling based on a standard mobile width (e.g., 375px)
  double w(double width) => (screenWidth / 375) * width;
  double h(double height) => (screenHeight / 812) * height;

  // Responsive padding/margins
  double get paddingSmall => w(8);
  double get paddingMedium => w(16);
  double get paddingLarge => w(24);

  // Check device type
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
}
