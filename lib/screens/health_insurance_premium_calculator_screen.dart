import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class HealthInsurancePremiumCalculatorScreen extends StatefulWidget {
  const HealthInsurancePremiumCalculatorScreen({super.key});

  @override
  State<HealthInsurancePremiumCalculatorScreen> createState() => _HealthInsurancePremiumCalculatorScreenState();
}

class _HealthInsurancePremiumCalculatorScreenState extends State<HealthInsurancePremiumCalculatorScreen> {
  String selectedAgeGroup = '18-30';
  String coverageAmount = '5 Lakhs';
  bool includeParents = false;
  bool criticalIllness = false;
  double? estimatedPremium;

  final List<String> ageGroups = ['18-30', '31-45', '46-60', '60+'];
  final List<String> coverageOptions = ['3 Lakhs', '5 Lakhs', '10 Lakhs', '25 Lakhs', '50 Lakhs'];

  void _calculate() {
    setState(() {
      double basePremium = 0;
      
      switch (selectedAgeGroup) {
        case '18-30':
          basePremium = 8000;
          break;
        case '31-45':
          basePremium = 12000;
          break;
        case '46-60':
          basePremium = 18000;
          break;
        case '60+':
          basePremium = 25000;
          break;
      }
      
      switch (coverageAmount) {
        case '3 Lakhs':
          basePremium *= 0.7;
          break;
        case '5 Lakhs':
          basePremium *= 1.0;
          break;
        case '10 Lakhs':
          basePremium *= 1.5;
          break;
        case '25 Lakhs':
          basePremium *= 2.5;
          break;
        case '50 Lakhs':
          basePremium *= 4.0;
          break;
      }
      
      if (includeParents) basePremium += 15000;
      if (criticalIllness) basePremium *= 1.3;
      
      estimatedPremium = basePremium;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Health Insurance Premium',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 20 : 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E3FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      color: Color(0xFF8B5CF6),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Premium Calculator',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B21A8),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Estimate your health insurance premium instantly',
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
            const SizedBox(height: 32),
            
            // Age Group
            _buildDropdownField(
              label: 'Age Group',
              value: selectedAgeGroup,
              options: ageGroups,
              onChanged: (value) => setState(() => selectedAgeGroup = value!),
            ),
            const SizedBox(height: 20),
            
            // Coverage Amount
            _buildDropdownField(
              label: 'Coverage Amount',
              value: coverageAmount,
              options: coverageOptions,
              onChanged: (value) => setState(() => coverageAmount = value!),
            ),
            const SizedBox(height: 20),
            
            // Add-ons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Additional Coverage',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    title: const Text('Include Parents'),
                    subtitle: const Text('Add ₹15,000/year'),
                    value: includeParents,
                    onChanged: (value) => setState(() => includeParents = value!),
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primary,
                  ),
                  CheckboxListTile(
                    title: const Text('Critical Illness Rider'),
                    subtitle: const Text('+30% on premium'),
                    value: criticalIllness,
                    onChanged: (value) => setState(() => criticalIllness = value!),
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Calculate Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Calculate Premium',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            if (estimatedPremium != null) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Estimated Annual Premium',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF059669),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${estimatedPremium!.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF059669),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF059669),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('View Plans'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
