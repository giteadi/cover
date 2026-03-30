import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static bool isWideDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1440;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Responsive padding
  static double getHorizontalPadding(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return 16; // Mobile
    if (width < 1024) return 32; // Tablet
    if (width < 1440) return 80; // Desktop
    return 120; // Wide desktop
  }

  static double getVerticalPadding(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return 40; // Mobile
    if (width < 1024) return 50; // Tablet
    return 60; // Desktop
  }

  // Responsive font sizes
  static double getHeadingSize(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return 28;
    if (width < 1024) return 36;
    if (width < 1440) return 48;
    return 56;
  }

  static double getSubheadingSize(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return 20;
    if (width < 1024) return 24;
    if (width < 1440) return 32;
    return 40;
  }

  static double getBodySize(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return 14;
    if (width < 1024) return 15;
    return 16;
  }

  static double getCaptionSize(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return 12;
    return 14;
  }

  // Responsive grid columns
  static int getGridCrossAxisCount(BuildContext context, {int maxColumns = 4}) {
    final width = getScreenWidth(context);
    if (width < 600) return 2; // Mobile - 2 columns
    if (width < 900) return 3; // Small tablet - 3 columns
    if (width < 1200) return 4; // Tablet/Laptop - 4 columns
    return maxColumns.clamp(4, 6); // Desktop - up to 6 columns
  }

  // Responsive spacing
  static double getSpacing(BuildContext context, {String size = 'medium'}) {
    final width = getScreenWidth(context);
    final baseSpacing = width < 600 ? 8.0 : (width < 1024 ? 12.0 : 16.0);
    
    switch (size) {
      case 'small':
        return baseSpacing * 0.5;
      case 'medium':
        return baseSpacing;
      case 'large':
        return baseSpacing * 2;
      case 'xlarge':
        return baseSpacing * 3;
      default:
        return baseSpacing;
    }
  }

  // Responsive card width
  static double getCardWidth(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) return (width - 48) / 2; // Mobile - 2 per row
    if (width < 900) return (width - 80) / 3; // Small tablet - 3 per row
    if (width < 1200) return 160; // Tablet
    return 180; // Desktop
  }
}

// Extension for easier access
extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveHelper.isMobile(this);
  bool get isTablet => ResponsiveHelper.isTablet(this);
  bool get isDesktop => ResponsiveHelper.isDesktop(this);
  bool get isWideDesktop => ResponsiveHelper.isWideDesktop(this);
  
  double get hPadding => ResponsiveHelper.getHorizontalPadding(this);
  double get vPadding => ResponsiveHelper.getVerticalPadding(this);
  double get headingSize => ResponsiveHelper.getHeadingSize(this);
  double get subheadingSize => ResponsiveHelper.getSubheadingSize(this);
  double get bodySize => ResponsiveHelper.getBodySize(this);
}
