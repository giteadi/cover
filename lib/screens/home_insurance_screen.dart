import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class HomeInsuranceScreen extends StatefulWidget {
  const HomeInsuranceScreen({super.key});

  @override
  State<HomeInsuranceScreen> createState() => _HomeInsuranceScreenState();
}

class _HomeInsuranceScreenState extends State<HomeInsuranceScreen> {
  String selectedCover = '50 Lakhs';
  String selectedTenure = '1 Year';
  double? estimatedPremium;

  final List<String> coverOptions = ['25 Lakhs', '50 Lakhs', '75 Lakhs', '1 Crore'];
  final List<String> tenureOptions = ['1 Year', '2 Years', '3 Years', '5 Years'];

  void _calculatePremium() {
    setState(() {
      double basePremium = 800;
      
      switch (selectedCover) {
        case '25 Lakhs':
          basePremium = 600;
          break;
        case '50 Lakhs':
          basePremium = 800;
          break;
        case '75 Lakhs':
          basePremium = 1100;
          break;
        case '1 Crore':
          basePremium = 1500;
          break;
      }
      
      switch (selectedTenure) {
        case '1 Year':
          basePremium *= 1;
          break;
        case '2 Years':
          basePremium *= 1.9;
          break;
        case '3 Years':
          basePremium *= 2.7;
          break;
        case '5 Years':
          basePremium *= 4.2;
          break;
      }
      
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
          'Home Insurance',
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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Limited Time Offer',
                      style: TextStyle(
                        color: Color(0xFF0EA5E9),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '₹50 Lakh Cover',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Starting at Just ₹80/month*',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildFeatureChip('Home Structure'),
                      const SizedBox(width: 8),
                      _buildFeatureChip('Contents'),
                      const SizedBox(width: 8),
                      _buildFeatureChip('Burglary'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Select Cover Amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: coverOptions.map((cover) {
                final isSelected = selectedCover == cover;
                return ChoiceChip(
                  label: Text(cover),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCover = cover;
                    });
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Policy Tenure',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: tenureOptions.map((tenure) {
                final isSelected = selectedTenure == tenure;
                return ChoiceChip(
                  label: Text(tenure),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedTenure = tenure;
                    });
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _calculatePremium,
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
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Estimated Premium',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${estimatedPremium!.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'for $selectedTenure',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
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
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Buy Now'),
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

  Widget _buildFeatureChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
