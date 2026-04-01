import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class PlanDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> plan;
  final String category;

  const PlanDetailsScreen({
    super.key,
    required this.plan,
    required this.category,
  });

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  String _selectedSumAssured = '1 Crore';
  String _selectedPolicyTerm = '30 Years';
  String _selectedPaymentMode = 'Annual';
  bool _isTermRiderSelected = true;
  bool _isAccidentalDeathSelected = true;
  bool _isCriticalIllnessSelected = false;

  final List<String> sumAssuredOptions = ['50 Lakhs', '75 Lakhs', '1 Crore', '1.5 Crore', '2 Crore'];
  final List<String> policyTermOptions = ['20 Years', '25 Years', '30 Years', '35 Years', '40 Years'];
  final List<String> paymentModes = ['Monthly', 'Quarterly', 'Half-Yearly', 'Annual'];

  double get _calculatedPremium {
    double basePremium = 1234;
    
    // Adjust based on sum assured
    switch (_selectedSumAssured) {
      case '50 Lakhs': basePremium *= 0.65; break;
      case '75 Lakhs': basePremium *= 0.80; break;
      case '1 Crore': basePremium *= 1.0; break;
      case '1.5 Crore': basePremium *= 1.35; break;
      case '2 Crore': basePremium *= 1.65; break;
    }
    
    // Adjust based on payment mode
    switch (_selectedPaymentMode) {
      case 'Monthly': basePremium *= 1.05; break;
      case 'Quarterly': basePremium *= 1.02; break;
      case 'Half-Yearly': basePremium *= 1.01; break;
      case 'Annual': basePremium *= 1.0; break;
    }
    
    // Add rider premiums
    if (_isTermRiderSelected) basePremium += 120;
    if (_isAccidentalDeathSelected) basePremium += 200;
    if (_isCriticalIllnessSelected) basePremium += 350;
    
    return basePremium;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final plan = widget.plan;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan['company'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share plan details')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading plan brochure...')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 80, vertical: 20),
          child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLeftColumn(plan),
                  const SizedBox(height: 20),
                  _buildRightColumn(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildLeftColumn(plan)),
                  const SizedBox(width: 24),
                  Expanded(flex: 1, child: _buildRightColumn()),
                ],
              ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${_calculatedPremium.toStringAsFixed(0)}/year',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      '₹${(_calculatedPremium / 12).toStringAsFixed(0)}/month',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed to Buy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn(Map<String, dynamic> plan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Plan Header Card
        Container(
          padding: const EdgeInsets.all(20),
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
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    plan['logo'],
                    style: const TextStyle(
                      fontSize: 24,
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            plan['discount'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber[600]),
                            const SizedBox(width: 2),
                            Text(
                              '${plan['rating']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
        ),

        const SizedBox(height: 20),

        // Key Features
        _buildSectionCard(
          'Key Features',
          Column(
            children: [
              _buildFeatureRow(Icons.verified, '98.5% Claim Settlement Ratio', 'One of the highest in the industry'),
              _buildFeatureRow(Icons.schedule, '30-Day Free Look Period', 'Cancel within 30 days for full refund'),
              _buildFeatureRow(Icons.receipt_long, 'Tax Benefits', 'Save up to ₹46,800 under Section 80C & 10D'),
              _buildFeatureRow(Icons.support_agent, '24x7 Customer Support', 'Dedicated claim assistance team'),
              _buildFeatureRow(Icons.shield, 'Terminal Illness Cover', '50% payout on terminal illness diagnosis'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Coverage Details
        _buildSectionCard(
          'Coverage Details',
          Column(
            children: [
              _buildDetailRow('Death Benefit', '100% of Sum Assured paid to nominee'),
              _buildDetailRow('Maturity Benefit', 'No maturity benefit (Pure Term Plan)'),
              _buildDetailRow('Accidental Death', 'Additional 100% if opted for rider'),
              _buildDetailRow('Critical Illness', 'Lump sum payout on 36 critical illnesses'),
              _buildDetailRow('Terminal Illness', 'Immediate 50% payout on diagnosis'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Policy Benefits
        _buildSectionCard(
          'Why Choose This Plan?',
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: plan['features'].map<Widget>((feature) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 16, color: Colors.blue[700]),
                    const SizedBox(width: 6),
                    Text(
                      feature,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        // Terms & Conditions
        _buildSectionCard(
          'Terms & Conditions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTermItem('Minimum Entry Age', '18 years'),
              _buildTermItem('Maximum Entry Age', '65 years'),
              _buildTermItem('Maximum Maturity Age', '85 years'),
              _buildTermItem('Policy Term', '10 to 40 years'),
              _buildTermItem('Grace Period', '30 days from due date'),
              _buildTermItem('Revival Period', '5 years from lapse'),
              const SizedBox(height: 12),
              Text(
                '*Suicide exclusion applicable for first 12 months. Please read the policy document carefully before purchasing.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      children: [
        // Customize Your Plan
        Container(
          padding: const EdgeInsets.all(20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customize Your Plan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Sum Assured
              _buildDropdownField(
                'Sum Assured',
                _selectedSumAssured,
                sumAssuredOptions,
                (value) => setState(() => _selectedSumAssured = value!),
              ),
              const SizedBox(height: 16),
              
              // Policy Term
              _buildDropdownField(
                'Policy Term',
                _selectedPolicyTerm,
                policyTermOptions,
                (value) => setState(() => _selectedPolicyTerm = value!),
              ),
              const SizedBox(height: 16),
              
              // Payment Mode
              _buildDropdownField(
                'Payment Mode',
                _selectedPaymentMode,
                paymentModes,
                (value) => setState(() => _selectedPaymentMode = value!),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Optional Riders
        Container(
          padding: const EdgeInsets.all(20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Optional Riders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildRiderCheckbox(
                'Term Rider',
                'Additional life cover',
                '₹120/year',
                _isTermRiderSelected,
                (value) => setState(() => _isTermRiderSelected = value!),
              ),
              const Divider(),
              _buildRiderCheckbox(
                'Accidental Death Benefit',
                'Double payout on accident',
                '₹200/year',
                _isAccidentalDeathSelected,
                (value) => setState(() => _isAccidentalDeathSelected = value!),
              ),
              const Divider(),
              _buildRiderCheckbox(
                'Critical Illness Cover',
                'Cover for 36 diseases',
                '₹350/year',
                _isCriticalIllnessSelected,
                (value) => setState(() => _isCriticalIllnessSelected = value!),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Premium Breakdown
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Premium Breakdown',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildPriceRow('Base Premium', '₹1,234'),
              if (_isTermRiderSelected)
                _buildPriceRow('Term Rider', '₹120'),
              if (_isAccidentalDeathSelected)
                _buildPriceRow('Accidental Death', '₹200'),
              if (_isCriticalIllnessSelected)
                _buildPriceRow('Critical Illness', '₹350'),
              const Divider(),
              _buildPriceRow(
                'Total Premium',
                '₹${_calculatedPremium.toStringAsFixed(0)}',
                isTotal: true,
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Save 5% with Annual Payment',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.green[700]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items: options.map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              )).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRiderCheckbox(
    String title,
    String subtitle,
    String price,
    bool value,
    Function(bool?) onChanged,
  ) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      secondary: Text(
        price,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.green[700],
        ),
      ),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.textPrimary : Colors.grey[600],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _proceedToPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You are about to purchase:'),
            const SizedBox(height: 12),
            Text(
              '${widget.plan['company']} ${widget.plan['plan']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Sum Assured: $_selectedSumAssured'),
            Text('Policy Term: $_selectedPolicyTerm'),
            const SizedBox(height: 12),
            Text(
              'Premium: ₹${_calculatedPremium.toStringAsFixed(0)}/year',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Capture scaffold context before async operations
              final scaffoldContext = context;
              // Navigate to payment or show success
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      const Text('Redirecting to payment gateway...'),
                    ],
                  ),
                ),
              );
              
              Future.delayed(const Duration(seconds: 2), () {
                if (scaffoldContext.mounted) {
                  Navigator.of(scaffoldContext, rootNavigator: true).pop();
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(
                      content: Text('Opening secure payment page...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm & Pay'),
          ),
        ],
      ),
    );
  }
}
