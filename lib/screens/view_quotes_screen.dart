import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'plan_details_screen.dart';
import 'compare_plans_screen.dart';

class ViewQuotesScreen extends StatefulWidget {
  final String category;
  final String name;
  final String gender;
  final String age;

  const ViewQuotesScreen({
    super.key,
    required this.category,
    required this.name,
    required this.gender,
    required this.age,
  });

  @override
  State<ViewQuotesScreen> createState() => _ViewQuotesScreenState();
}

class _ViewQuotesScreenState extends State<ViewQuotesScreen> {
  String _selectedSort = 'Lowest Premium';
  String _selectedCoverage = '1 Crore';
  String _selectedTerm = '30 Years';
  List<Map<String, dynamic>> _selectedPlans = [];

  // Getter for filtered and sorted plans
  List<Map<String, dynamic>> get filteredPlans {
    // Filter by coverage
    var filtered = plans.where((plan) {
      return plan['coverage'] == _selectedCoverage;
    }).toList();
    
    // Sort based on selected sort option
    if (_selectedSort == 'Lowest Premium') {
      filtered.sort((a, b) {
        final premiumA = int.parse(a['premium'].toString().replaceAll(RegExp(r'[^0-9]'), ''));
        final premiumB = int.parse(b['premium'].toString().replaceAll(RegExp(r'[^0-9]'), ''));
        return premiumA.compareTo(premiumB);
      });
    } else if (_selectedSort == 'Best Rating') {
      filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
    }
    // For 'Highest Coverage', we'd need different data
    
    return filtered;
  }

  // Sample insurance plans
  final List<Map<String, dynamic>> plans = [
    {
      'company': 'HDFC Life',
      'logo': 'HDFC',
      'plan': 'Click 2 Protect Super',
      'premium': '₹1,234',
      'monthly': '₹103/month',
      'coverage': '₹1 Crore',
      'features': ['98.5% Claim Settlement', 'Terminal Illness Cover', 'No Medicals Required'],
      'discount': '20% OFF',
      'rating': 4.8,
      'popular': true,
    },
    {
      'company': 'Max Life',
      'logo': 'Max',
      'plan': 'Smart Secure Plus',
      'premium': '₹1,456',
      'monthly': '₹121/month',
      'coverage': '₹1 Crore',
      'features': ['99.3% Claim Settlement', 'Premium Return Option', 'Waiver of Premium'],
      'discount': '15% OFF',
      'rating': 4.7,
      'popular': false,
    },
    {
      'company': 'ICICI Prudential',
      'logo': 'ICICI',
      'plan': 'iProtect Smart',
      'premium': '₹1,378',
      'monthly': '₹115/month',
      'coverage': '₹1 Crore',
      'features': ['98.8% Claim Settlement', 'Income Payout Option', 'Accidental Cover'],
      'discount': '18% OFF',
      'rating': 4.6,
      'popular': false,
    },
    {
      'company': 'Tata AIA',
      'logo': 'Tata',
      'plan': 'Sampoorna Raksha',
      'premium': '₹1,567',
      'monthly': '₹131/month',
      'coverage': '₹1 Crore',
      'features': ['98.6% Claim Settlement', 'Whole Life Cover', 'Cancer Cover Included'],
      'discount': '12% OFF',
      'rating': 4.5,
      'popular': false,
    },
    {
      'company': 'Bajaj Allianz',
      'logo': 'Bajaj',
      'plan': 'Smart Protect Goal',
      'premium': '₹1,289',
      'monthly': '₹107/month',
      'coverage': '₹1 Crore',
      'features': ['98.4% Claim Settlement', 'Critical Illness Rider', 'Return of Premium'],
      'discount': '25% OFF',
      'rating': 4.4,
      'popular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.shield, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CoverShield',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'HAR FAMILY HOgi INSURED',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Compare Plans Button - Always Visible
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComparePlansScreen(
                      plans: _selectedPlans,
                      category: widget.category,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.compare_arrows, size: 18),
              label: Text('Compare (${_selectedPlans.length})'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.blue.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green[300]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user, size: 16, color: Colors.green[700]),
                const SizedBox(width: 4),
                Text(
                  '${widget.name}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 80, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.category} Plans for ${widget.name}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Based on ${widget.gender}, Age ${widget.age} | ${_selectedCoverage} Coverage',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Filters
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildFilterChip('Coverage', _selectedCoverage, ['50 Lakhs', '1 Crore', '2 Crore', '5 Crore']),
                      _buildFilterChip('Policy Term', _selectedTerm, ['20 Years', '25 Years', '30 Years', '35 Years']),
                      _buildFilterChip('Sort By', _selectedSort, ['Lowest Premium', 'Highest Coverage', 'Best Rating']),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Plans List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 80),
              child: Column(
                children: [
                  // Results count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filteredPlans.length} Plans Found',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.verified, size: 16, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            'Prices Guaranteed for 30 Days',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Plan Cards
                  ...filteredPlans.map((plan) => _buildPlanCard(plan, isMobile)),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, List<String> options) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Select $label'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((opt) => ListTile(
                title: Text(opt),
                trailing: value == opt ? const Icon(Icons.check, color: AppColors.primary) : null,
                onTap: () {
                  setState(() {
                    if (label == 'Coverage') _selectedCoverage = opt;
                    if (label == 'Policy Term') _selectedTerm = opt;
                    if (label == 'Sort By') _selectedSort = opt;
                  });
                  Navigator.pop(context);
                },
              )).toList(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (plan['popular'])
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFFFF6B00),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Text(
                'MOST POPULAR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Checkbox Row for Compare
                Row(
                  children: [
                    Checkbox(
                      value: _selectedPlans.any((p) => p['company'] == plan['company'] && p['plan'] == plan['plan']),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            if (_selectedPlans.length < 3) {
                              _selectedPlans.add(plan);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('You can compare max 3 plans')),
                              );
                            }
                          } else {
                            _selectedPlans.removeWhere((p) => p['company'] == plan['company'] && p['plan'] == plan['plan']);
                          }
                        });
                      },
                    ),
                    const Text(
                      'Add to Compare',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Company & Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              plan['logo'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan['company'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              plan['plan'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.green[700]),
                          const SizedBox(width: 2),
                          Text(
                            '${plan['rating']}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Premium & Discount Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              plan['premium'],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                plan['discount'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '/year (${plan['monthly']})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Coverage',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          plan['coverage'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Features
                ...plan['features'].map<Widget>((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: Colors.green[600]),
                      const SizedBox(width: 8),
                      Text(
                        feature,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanDetailsScreen(
                                plan: plan,
                                category: widget.category,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanDetailsScreen(
                                plan: plan,
                                category: widget.category,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Buy Now'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPlanDetails(Map<String, dynamic> plan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          plan['logo'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan['company'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            plan['plan'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildDetailRow('Annual Premium', plan['premium']),
                _buildDetailRow('Monthly Premium', plan['monthly']),
                _buildDetailRow('Sum Assured', plan['coverage']),
                _buildDetailRow('Policy Term', _selectedTerm),
                _buildDetailRow('Claim Settlement', '${plan['rating']}%'),
                const SizedBox(height: 24),
                const Text(
                  'Key Features',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...plan['features'].map<Widget>((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 20, color: Colors.green[600]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _buyPlan(plan),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Proceed to Buy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _buyPlan(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text('You are about to purchase ${plan['plan']} from ${plan['company']} for ${plan['premium']}/year.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Redirecting to ${plan['company']} payment page...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }

  void _downloadQuotesPDF() {
    // Show dialog with PDF download simulation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.picture_as_pdf, color: Colors.red[700]),
            const SizedBox(width: 8),
            const Text('Download Quotes'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${filteredPlans.length} insurance plans will be downloaded as PDF.'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PDF Contents:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPdfItem('${widget.category} Plans Comparison'),
                  _buildPdfItem('Coverage Details'),
                  _buildPdfItem('Premium Breakdown'),
                  _buildPdfItem('Terms & Conditions'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // Simulate download
              late BuildContext loadingContext;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  loadingContext = context;
                  return const AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20),
                        Text('Generating PDF...'),
                      ],
                    ),
                  );
                },
              );
              
              Future.delayed(const Duration(seconds: 2), () {
                if (Navigator.canPop(loadingContext)) {
                  Navigator.pop(loadingContext);
                }
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Quotes PDF downloaded successfully!'),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              });
            },
            icon: const Icon(Icons.download),
            label: const Text('Download'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showComparison() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Compare Plans',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Side-by-side comparison of selected plans',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Feature Labels Column
                      Container(
                        width: 150,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCompareLabel('Company'),
                            _buildCompareLabel('Plan Name'),
                            _buildCompareLabel('Annual Premium'),
                            _buildCompareLabel('Monthly Premium'),
                            _buildCompareLabel('Coverage'),
                            _buildCompareLabel('Claim Settlement'),
                            _buildCompareLabel('Rating'),
                            _buildCompareLabel('Discount'),
                          ],
                        ),
                      ),
                      // Plan Columns
                      ..._selectedPlans.map((plan) => Container(
                        width: 200,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCompareValue(plan['company'], isBold: true, color: AppColors.primary),
                            _buildCompareValue(plan['plan'], isBold: true),
                            _buildCompareValue(plan['premium'], isBold: true, color: Colors.green[700]),
                            _buildCompareValue(plan['monthly']),
                            _buildCompareValue(plan['coverage'], isBold: true),
                            _buildCompareValue('${plan['rating']}%'),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.amber[600]),
                                Text(' ${plan['rating']}'),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                plan['discount'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  final planToBuy = plan;
                                  Future.microtask(() => _buyPlan(planToBuy));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                ),
                                child: const Text('Buy Now', style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompareLabel(String text) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildCompareValue(String text, {bool isBold = false, Color? color}) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: color ?? AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildPdfItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.check, size: 14, color: Colors.green[600]),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
