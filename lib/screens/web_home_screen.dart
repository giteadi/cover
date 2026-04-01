import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/mock_data.dart';
import '../models/policy.dart';
import '../utils/responsive_helper.dart';
import 'insurance_form_screen.dart';
import 'policy_renewal_screen.dart';
import 'bmi_calculator_screen.dart';
import 'life_insurance_calculator_screen.dart';
import 'health_insurance_premium_calculator_screen.dart';
import 'home_insurance_screen.dart';
import 'ask_covershield_screen.dart';
import 'login_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  int _currentBannerIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'Save 15%',
      'subtitle': 'On Your Plan',
      'description': 'Get a discount on Health Insurance',
      'color': const Color(0xFF1E3A8A),
    },
    {
      'title': '₹50 Lakh Cover',
      'subtitle': 'Home Insurance',
      'description': 'Starting at Just ₹80/month*',
      'color': const Color(0xFF0EA5E9),
    },
    {
      'title': 'Ask CoverShield',
      'subtitle': 'Got a question?',
      'description': 'Write to us about insurance',
      'color': const Color(0xFFF97316),
    },
  ];

  final List<Map<String, dynamic>> _mobileNavItems = [
    {'icon': Icons.shield, 'label': 'Insurance Products', 'color': AppColors.primary},
    {'icon': Icons.refresh, 'label': 'Renew Your Policy', 'color': AppColors.primary},
    {'icon': Icons.support_agent, 'label': 'Claim', 'color': AppColors.primary},
    {'icon': Icons.help_outline, 'label': 'Support', 'color': AppColors.primary},
    {'icon': Icons.calculate, 'label': 'Calculators', 'color': AppColors.primary},
    {'icon': Icons.compare, 'label': 'Compare Plans', 'color': AppColors.primary},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _buildWebAppBar(),
      drawer: context.isMobile ? _buildMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildInsuranceCategories(),
            _buildPromoBanners(),
            _buildPopularCalculators(),
            _buildStatsSection(),
            _buildAdvantagesSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.shield, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CoverShield',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Compare & Buy Insurance',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: _mobileNavItems.length,
                  itemBuilder: (context, index) {
                    final item = _mobileNavItems[index];
                    return ListTile(
                      leading: Icon(item['icon'] as IconData, color: item['color'] as Color),
                      title: Text(
                        item['label'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                        label: const Text('Talk to Expert'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Sign In / Sign Up'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildWebAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      leading: context.isMobile
          ? IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            )
          : null,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 1200;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 20),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.shield, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CoverShield',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        if (isWide)
                          const Text(
                            'Compare & Buy Insurance',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                if (isWide) ...[
                  _buildInsuranceProductsDropdown(),
                  _buildRenewPolicyDropdown(),
                  _buildClaimDropdown(),
                  _buildSupportDropdown(),
                  const SizedBox(width: 16),
                ],
                if (!context.isMobile)
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone, size: 16),
                    label: Text(isWide ? 'Talk to Expert' : ''),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                if (!context.isMobile) ...[
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceProductsDropdown() {
    final insuranceProducts = {
      'Term Insurance': [
        'Term Insurance',
        'Life Insurance',
        'Best Term Insurance Plan',
        'Term Insurance for NRI',
        'What is Term Insurance',
        '1 Crore Term Insurance',
        'Term Insurance Calculator',
        'Dedicated Claim Assistance',
        'Term Insurance for Women',
        'Term Insurance for HNI',
        'Term Insurance Return of Premium',
      ],
      'Other Insurance': [
        'Travel Insurance',
        'International Travel Insurance',
        'Schengen travel insurance',
        'Group Health Insurance',
        'Marine Insurance',
        'Workmen Compensation Policy',
        'Professional Indemnity',
        'Doctors Indemnity Insurance',
        'Fire Insurance',
        'Shopkeepers Insurance',
        'Office Insurance',
        'Comprehensive General Liability',
        'Cyber Insurance',
        'Contractors All Risk',
        'Surety Bond',
        'Home Insurance',
        'Home Loan Insurance',
        'Home Loan EMI Calculator',
        'Pet Insurance',
        'Cancer Insurance',
        'Defence Personnel Insurance',
        'General Insurance',
      ],
      'Health Insurance': [
        'Book Free Home Visit',
        'Family Health Insurance',
        'Senior Citizen Health Insurance',
        'Health Insurance for Parents',
        'Maternity Insurance',
        'Network Hospitals',
        'Health Insurance Portability',
        'OPD Cover In Health Insurance',
        'Mediclaim Policy',
        'Critical Illness Insurance',
        'Health Insurance Calculator',
        'Health Insurance Companies',
        'Types of Health Insurance',
        'Health Insurance for NRIs',
      ],
      'Car Insurance': [
        'Motor Insurance',
        'Bike Insurance',
        'Zero Dep Car Insurance',
        'Third Party Insurance',
        'Third Party Bike Insurance',
        'Car Insurance Calculator',
        'Bike Insurance Calculator',
        'Car Insurance Companies',
        'Pay As You Drive Insurance',
        'Commercial Vehicle Insurance',
        'Electric Car Insurance',
        'E-Bike Insurance',
        'IDV Calculator',
        'Comprehensive Insurance',
        'New Car Insurance',
        'Car Insurance Status',
      ],
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Insurance Products',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.primary,
            ),
          ],
        ),
        itemBuilder: (context) {
          final entriesList = insuranceProducts.entries.toList();
          final midPoint = (entriesList.length / 2).ceil();
          final leftColumns = entriesList.sublist(0, midPoint);
          final rightColumns = entriesList.sublist(midPoint);

          return [
            PopupMenuItem<String>(
              enabled: false,
              child: Container(
                width: 700,
                constraints: const BoxConstraints(maxHeight: 550),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side columns
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: leftColumns.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                  child: Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const Divider(height: 1),
                                ...entry.value.map((item) {
                                  return ListTile(
                                    dense: true,
                                    title: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InsuranceFormScreen(category: item),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                                const SizedBox(height: 8),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      // Right side columns
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: rightColumns.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                  child: Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const Divider(height: 1),
                                ...entry.value.map((item) {
                                  return ListTile(
                                    dense: true,
                                    title: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InsuranceFormScreen(category: item),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                                const SizedBox(height: 8),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  Widget _buildRenewPolicyDropdown() {
    final renewOptions = [
      {'icon': Icons.umbrella, 'title': 'Term Life Renewal', 'color': Color(0xFF8B5CF6)},
      {'icon': Icons.favorite, 'title': 'Health Renewal', 'color': Color(0xFFEF4444)},
      {'icon': Icons.directions_car, 'title': 'Motor Renewal', 'color': Color(0xFF3B82F6)},
      {'icon': Icons.two_wheeler, 'title': 'Two Wheeler Renewal', 'color': Color(0xFF10B981)},
      {'icon': Icons.home, 'title': 'Home Insurance Renewal', 'color': Color(0xFF06B6D4)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        constraints: const BoxConstraints(minWidth: 280),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Renew Your Policy',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        itemBuilder: (context) {
          return renewOptions.map((option) {
            return PopupMenuItem<String>(
              value: option['title'] as String,
              child: ListTile(
                leading: Icon(
                  option['icon'] as IconData,
                  color: option['color'] as Color,
                  size: 20,
                ),
                title: Text(
                  option['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onTap: () {
                Navigator.pop(context);
                final optionTitle = option['title'] as String;
                if (optionTitle == 'Term Life Renewal') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolicyRenewalScreen(
                        renewalType: 'Term Life',
                        title: 'Term Life Renewal',
                        icon: Icons.umbrella,
                        themeColor: option['color'] as Color,
                      ),
                    ),
                  );
                } else if (optionTitle == 'Health Renewal') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolicyRenewalScreen(
                        renewalType: 'Health',
                        title: 'Health Renewal',
                        icon: Icons.favorite,
                        themeColor: option['color'] as Color,
                      ),
                    ),
                  );
                } else if (optionTitle == 'Motor Renewal') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolicyRenewalScreen(
                        renewalType: 'Motor',
                        title: 'Motor Renewal',
                        icon: Icons.directions_car,
                        themeColor: option['color'] as Color,
                      ),
                    ),
                  );
                } else if (optionTitle == 'Two Wheeler Renewal') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolicyRenewalScreen(
                        renewalType: 'Two Wheeler',
                        title: 'Two Wheeler Renewal',
                        icon: Icons.two_wheeler,
                        themeColor: option['color'] as Color,
                      ),
                    ),
                  );
                } else if (optionTitle == 'Home Insurance Renewal') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolicyRenewalScreen(
                        renewalType: 'Home',
                        title: 'Home Insurance Renewal',
                        icon: Icons.home,
                        themeColor: option['color'] as Color,
                      ),
                    ),
                  );
                }
              },
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildClaimDropdown() {
    final claimOptions = [
      'File a new claim',
      'Claim is already filed with the Insurer',
      'Know more about filing claim',
      'Track existing claim',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        constraints: const BoxConstraints(minWidth: 320),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Claim',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        itemBuilder: (context) {
          return claimOptions.map((option) {
            return PopupMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                if (option == 'File a new claim') {
                  Navigator.pushNamed(context, '/claim-assistance');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$option - Coming Soon!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildSupportDropdown() {
    final supportOptions = [
      {'icon': Icons.receipt_long, 'title': 'Track payments / policy status'},
      {'icon': Icons.verified_user, 'title': 'Verify advisor'},
      {'icon': Icons.policy, 'title': 'View / manage policies'},
      {'icon': Icons.feedback, 'title': 'Advisor Feedback'},
      {'icon': Icons.assignment, 'title': 'Claims'},
      {'icon': Icons.phone_callback, 'title': 'Get a call back'},
      {'icon': Icons.settings, 'title': 'Communication preferences'},
      {'icon': Icons.chat, 'title': 'Chat With Us'},
      {'icon': Icons.help_outline, 'title': 'Get help/Report an issue'},
      {'icon': Icons.more_horiz, 'title': 'View more'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        constraints: const BoxConstraints(minWidth: 320, maxWidth: 400),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Support',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem<String>(
              enabled: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account & Service Help',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Log in to your account to get personalised support.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Login with email',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const PopupMenuDivider(),
            ...supportOptions.map((option) {
              return PopupMenuItem<String>(
                value: option['title'] as String,
                child: ListTile(
                  leading: Icon(
                    option['icon'] as IconData,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  title: Text(
                    option['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${option['title']} - Coming Soon!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            }).toList(),
          ];
        },
      ),
    );
  }

  Widget _buildHeroSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final isMobile = constraints.maxWidth < 600;
        final padding = context.hPadding;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: context.vPadding),
          child: isWide 
            ? Row(
                children: [
                  Expanded(child: _buildHeroContent(isWide, isMobile)),
                  const SizedBox(width: 60),
                  Expanded(child: _buildHeroBanner(isMobile)),
                ],
              )
            : Column(
                children: [
                  _buildHeroContent(isWide, isMobile),
                  const SizedBox(height: 40),
                  _buildHeroBanner(isMobile),
                ],
              ),
        );
      },
    );
  }

  Widget _buildHeroContent(bool isWide, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 6 : 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.verified, color: AppColors.primary, size: isMobile ? 16 : 20),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                '51 insurers offering lowest prices',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "Let's find you",
          style: TextStyle(
            fontSize: context.headingSize * (isMobile ? 0.7 : (isWide ? 1 : 0.85)),
            fontWeight: FontWeight.w300,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          'the Best Insurance',
          style: TextStyle(
            fontSize: context.headingSize * (isMobile ? 0.7 : (isWide ? 1 : 0.85)),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 6 : 8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bolt, color: Colors.orange, size: isMobile ? 16 : 20),
            ),
            const SizedBox(width: 12),
            Text(
              'Quick, easy & hassle free',
              style: TextStyle(
                color: Colors.orange,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search insurance plans...',
                    prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isMobile ? 'Go' : 'Search',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner(bool isMobile) {
    return Container(
      height: isMobile ? 320 : 400,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Limited Time Offer',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 10 : 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Get a discount on\nHealth Insurance',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Save',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '15%',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'On Your Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Valid Until\nMarch 31st',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 10 : 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32, vertical: 16),
            ),
            child: Text(
              'View plans →',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 14 : 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceCategories() {
    final categories = [
      {'name': 'Term Life Insurance', 'icon': Icons.shield, 'discount': 'Upto 15% Discount', 'color': Color(0xFF8B5CF6)},
      {'name': 'Health Insurance', 'icon': Icons.favorite, 'discount': 'Upto 25% Discount', 'color': Color(0xFFEF4444)},
      {'name': 'Car Insurance', 'icon': Icons.directions_car, 'discount': 'Lowest Price Guarantee', 'color': Color(0xFF3B82F6)},
      {'name': '2 Wheeler Insurance', 'icon': Icons.two_wheeler, 'discount': 'Upto 85% Discount', 'color': Color(0xFF10B981)},
      {'name': 'Family Health Insurance', 'icon': Icons.family_restroom, 'discount': 'Upto 25% Discount', 'color': Color(0xFFEC4899)},
      {'name': 'Travel Insurance', 'icon': Icons.flight, 'discount': '', 'color': Color(0xFF06B6D4)},
      {'name': 'Home Insurance', 'icon': Icons.home, 'discount': 'Property Protection', 'color': Color(0xFF8B5CF6)},
      {'name': 'Commercial Vehicle', 'icon': Icons.local_shipping, 'discount': '', 'color': Color(0xFF6366F1)},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final padding = isWide ? 80.0 : 24.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 60),
          child: Column(
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: categories.map((cat) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InsuranceFormScreen(category: cat['name'] as String),
                        ),
                      );
                    },
                    child: _buildCategoryCard(
                      cat['name'] as String,
                      cat['icon'] as IconData,
                      cat['discount'] as String,
                      cat['color'] as Color,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  side: const BorderSide(color: AppColors.primary),
                ),
                child: const Text('View all products'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(String name, IconData icon, String discount, Color color) {
    return _HoverCategoryCard(
      name: name,
      icon: icon,
      discount: discount,
      color: color,
    );
  }

  Widget _buildPromoBanners() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final padding = isWide ? 80.0 : 24.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 40),
          child: isWide
            ? Row(
                children: _banners.map((banner) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildBannerCard(banner),
                    ),
                  );
                }).toList(),
              )
            : Column(
                children: _banners.map((banner) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: _buildBannerCard(banner),
                  );
                }).toList(),
              ),
        );
      },
    );
  }

  Widget _buildBannerCard(Map<String, dynamic> banner) {
    return GestureDetector(
      onTap: () {
        if (banner['title'] == '₹50 Lakh Cover') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeInsuranceScreen()),
          );
        } else if (banner['title'] == 'Ask CoverShield') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AskCoverShieldScreen()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              banner['color'] as Color,
              (banner['color'] as Color).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.savings, color: Colors.white, size: 20),
                ),
                const Spacer(),
                if (banner['title']!.contains('%'))
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      banner['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (!banner['title']!.contains('%'))
              Text(
                banner['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Text(
              banner['description']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (banner['title'] == '₹50 Lakh Cover') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeInsuranceScreen()),
                  );
                } else if (banner['title'] == 'Ask CoverShield') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AskCoverShieldScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: banner['color'] as Color,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Calculate now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCalculators() {
    final calculatorGroups = [
      {
        'title': 'Health & Wellness calculators',
        'icon': Icons.health_and_safety,
        'bgColor': const Color(0xFFD1FAE5),
        'calculators': ['BMI Calculator', 'Ideal Weight Calculator', 'Calorie Calculator', 'Body Fat Calculator'],
      },
      {
        'title': 'Term Insurance calculators',
        'icon': Icons.shield,
        'bgColor': const Color(0xFFDBEAFE),
        'calculators': ['Life Insurance Calculator', 'Term Insurance Calculator', 'Human Life Value Calculator', 'NRI Term Insurance Calculator'],
      },
      {
        'title': 'Policy premium calculators',
        'icon': Icons.calculate,
        'bgColor': const Color(0xFFE9E3FF),
        'calculators': ['Health Insurance Premium Calculator', 'Car Insurance Calculator', 'Bike Insurance Calculator', 'Travel Insurance Calculator'],
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final padding = isWide ? 80.0 : 24.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 60),
          color: const Color(0xFFF8FAFC),
          child: Column(
            children: [
              const Text(
                'Popular calculators',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Discover our user-friendly calculators tailored to help you make informed financial decisions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              isWide
                ? Row(
                    children: calculatorGroups.map((group) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: _buildCalculatorCard(group),
                        ),
                      );
                    }).toList(),
                  )
                : Column(
                    children: calculatorGroups.map((group) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: _buildCalculatorCard(group),
                      );
                    }).toList(),
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalculatorCard(Map<String, dynamic> group) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : 20),
            decoration: BoxDecoration(
              color: group['bgColor'] as Color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(group['icon'] as IconData, color: AppColors.primary, size: isMobile ? 24 : 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    group['title'] as String,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...((group['calculators'] as List<String>).map((calc) {
            return ListTile(
              dense: isMobile,
              title: Text(
                calc,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  color: AppColors.textPrimary,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward, size: 18, color: AppColors.textSecondary),
              onTap: () {
                if (calc == 'BMI Calculator') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BMICalculatorScreen()),
                  );
                } else if (calc == 'Life Insurance Calculator') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LifeInsuranceCalculatorScreen()),
                  );
                } else if (calc == 'Health Insurance Premium Calculator') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HealthInsurancePremiumCalculatorScreen()),
                  );
                }
              },
            );
          }).toList()),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final padding = isWide ? 80.0 : 24.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What makes',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'CoverShield ',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Text(
                    'one of',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const Text(
                "India's favourite places\nto buy insurance?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 40),
              isWide
                ? Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Over 9 million',
                          'customers trust us & have bought their insurance on CoverShield',
                          Icons.people,
                          AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildStatCard(
                          '51 insurers',
                          'partnered with us so that you can compare easily & transparently',
                          Icons.business,
                          Color(0xFF0EA5E9),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildStatCard(
                          'Great Price',
                          'for all kinds of insurance plans available online',
                          Icons.local_offer,
                          Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildStatCard(
                          'Claims',
                          'support built in with every policy for help, when you need it the most',
                          Icons.support_agent,
                          Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _buildStatCard(
                        'Over 9 million',
                        'customers trust us & have bought their insurance on CoverShield',
                        Icons.people,
                        AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        '51 insurers',
                        'partnered with us so that you can compare easily & transparently',
                        Icons.business,
                        Color(0xFF0EA5E9),
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        'Great Price',
                        'for all kinds of insurance plans available online',
                        Icons.local_offer,
                        Color(0xFF10B981),
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        'Claims',
                        'support built in with every policy for help, when you need it the most',
                        Icons.support_agent,
                        Color(0xFFF59E0B),
                      ),
                    ],
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String description, IconData icon, Color color) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: isMobile ? 28 : 32),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: isMobile ? 6 : 8),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantagesSection() {
    final advantages = [
      {'icon': Icons.local_offer, 'title': 'One of the best Prices', 'subtitle': 'Guaranteed', 'color': Color(0xFF8B5CF6)},
      {'icon': Icons.balance, 'title': 'Unbiased Advice', 'subtitle': 'Keeping customers first', 'color': Color(0xFF0EA5E9)},
      {'icon': Icons.verified, 'title': '100% Reliable', 'subtitle': 'Regulated by IRDAI', 'color': Color(0xFF10B981)},
      {'icon': Icons.headset_mic, 'title': 'Claims Support', 'subtitle': 'Made stress-free', 'color': Color(0xFFEF4444)},
      {'icon': Icons.calendar_today, 'title': 'Happy to Help', 'subtitle': 'Every day of the week', 'color': Color(0xFFF59E0B)},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final padding = isWide ? 80.0 : 24.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 60),
          color: const Color(0xFFF8FAFC),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CoverShield Advantage',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'When you buy insurance from us, you get more than just financial safety. You also get: our promise of simplifying complex insurance terms and conditions, quick stress-free claims, instant quotes from top insurers and being present for you in the toughest of times.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),
              isWide
                ? Row(
                    children: advantages.map((adv) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Icon(adv['icon'] as IconData, color: adv['color'] as Color, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                adv['title'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                adv['subtitle'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Column(
                    children: advantages.map((adv) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            Icon(adv['icon'] as IconData, color: adv['color'] as Color, size: 36),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    adv['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    adv['subtitle'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 1000;
        final padding = isWide ? 80.0 : 24.0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 60),
          color: const Color(0xFF1E293B),
          child: Column(
            children: [
              isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildFooterBrand(),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: _buildFooterColumn('Insurance', ['Health Insurance', 'Term Insurance', 'Car Insurance', 'Bike Insurance', 'Travel Insurance']),
                      ),
                      Expanded(
                        child: _buildFooterColumn('Company', ['About Us', 'Careers', 'Press', 'Blog', 'Contact']),
                      ),
                      Expanded(
                        child: _buildFooterColumn('Support', ['Help Center', 'Claims', 'Renewals', 'FAQ', 'Grievances']),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterBrand(),
                      const SizedBox(height: 40),
                      _buildFooterColumn('Insurance', ['Health Insurance', 'Term Insurance', 'Car Insurance', 'Bike Insurance', 'Travel Insurance']),
                      const SizedBox(height: 24),
                      _buildFooterColumn('Company', ['About Us', 'Careers', 'Press', 'Blog', 'Contact']),
                      const SizedBox(height: 24),
                      _buildFooterColumn('Support', ['Help Center', 'Claims', 'Renewals', 'FAQ', 'Grievances']),
                    ],
                  ),
              const Divider(color: Colors.white24, height: 60),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2024 CoverShield. All rights reserved. IRDAI Registered',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                  Row(
                    children: [
                      Text('Privacy Policy', style: TextStyle(fontSize: 12, color: Colors.white54)),
                      SizedBox(width: 24),
                      Text('Terms of Service', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooterBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'CoverShield',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Get the CoverShield app',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Get control of all your insurance needs anywhere, anytime',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              link,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _HoverCategoryCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final String discount;
  final Color color;

  const _HoverCategoryCard({
    required this.name,
    required this.icon,
    required this.discount,
    required this.color,
  });

  @override
  State<_HoverCategoryCard> createState() => _HoverCategoryCardState();
}

class _HoverCategoryCardState extends State<_HoverCategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final cardWidth = isMobile ? (width - 48) / 2 : 160.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        height: isMobile ? 150 : 170,
        padding: EdgeInsets.all(isMobile ? 10 : 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered ? AppColors.primary : AppColors.border,
            width: isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: isHovered ? 20 : 10,
              spreadRadius: isHovered ? 2 : 0,
              offset: Offset(0, isHovered ? 8 : 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: isMobile ? 18 : 20,
              alignment: Alignment.center,
              child: widget.discount.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.discount,
                        style: TextStyle(
                          fontSize: isMobile ? 9 : 10,
                          color: widget.color,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: isMobile ? 6 : 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(isHovered ? 14 : (isMobile ? 10 : 12)),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: isHovered ? 0.2 : 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: isMobile ? 22 : (isHovered ? 28 : 24),
              ),
            ),
            SizedBox(height: isMobile ? 6 : 8),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 12 : (isHovered ? 14 : 13),
                fontWeight: isHovered ? FontWeight.bold : FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
