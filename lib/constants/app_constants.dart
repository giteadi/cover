import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF1E40AF);
  static const Color accent = Color(0xFF10B981);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
}

class AppConstants {
  static const String appName = 'CoverShield';
  static const String tagline = 'Compare & Buy Insurance';
  
  static const List<Map<String, dynamic>> insuranceCategories = [
    {
      'id': 'health',
      'name': 'Health Insurance',
      'icon': Icons.health_and_safety,
      'color': Color(0xFF10B981),
      'description': 'Protect your family\'s health',
    },
    {
      'id': 'life',
      'name': 'Term Life',
      'icon': Icons.favorite,
      'color': Color(0xFFEF4444),
      'description': 'Secure your family\'s future',
    },
    {
      'id': 'motor',
      'name': 'Motor Insurance',
      'icon': Icons.directions_car,
      'color': Color(0xFF3B82F6),
      'description': 'Cover your vehicles',
    },
    {
      'id': 'investment',
      'name': 'ULIPs & LIC',
      'icon': Icons.trending_up,
      'color': Color(0xFF8B5CF6),
      'description': 'Invest & insure together',
    },
  ];
}
