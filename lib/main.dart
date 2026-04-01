import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/app_constants.dart';
import 'screens/home_screen.dart';
import 'screens/web_home_screen.dart';
import 'screens/policy_list_screen.dart';
import 'screens/compare_screen.dart';
import 'screens/premium_calculator_screen.dart';
import 'screens/claim_assistance_screen.dart';
import 'screens/term_life_form_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with default options for web
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDummyKeyForWeb",
        authDomain: "covershield-demo.firebaseapp.com",
        projectId: "covershield-demo",
        storageBucket: "covershield-demo.appspot.com",
        messagingSenderId: "123456789",
        appId: "1:123456789:web:abcdef123456",
      ),
    );
  } catch (e) {
    print('Firebase initialization skipped or failed: $e');
  }
  
  runApp(const CoverShieldApp());
}

class CoverShieldApp extends StatelessWidget {
  const CoverShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoverShield',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const ResponsiveLayout(),
      routes: {
        '/policies': (context) => const PolicyListScreen(),
        '/compare': (context) => const CompareScreen(),
        '/calculator': (context) => const PremiumCalculatorScreen(),
        '/claims': (context) => const ClaimAssistanceScreen(),
        '/web': (context) => const WebHomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const WebHomeScreen();
        }
        return const MainNavigation();
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PolicyListScreen(),
    const PremiumCalculatorScreen(),
    const ClaimAssistanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
                _buildNavItem(Icons.shield_outlined, Icons.shield, 'Plans', 1),
                _buildNavItem(Icons.calculate_outlined, Icons.calculate, 'Calculator', 2),
                _buildNavItem(Icons.support_agent_outlined, Icons.support_agent, 'Claims', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData inactiveIcon, IconData activeIcon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
