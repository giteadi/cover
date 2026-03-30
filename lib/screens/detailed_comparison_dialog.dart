import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/policy.dart';

class DetailedComparisonDialog extends StatelessWidget {
  final List<InsurancePolicy> policies;

  const DetailedComparisonDialog({super.key, required this.policies});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? 16 : 40),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          maxWidth: isMobile ? double.infinity : 1000,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Plan Comparison',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Compare ${policies.length} plans side by side',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Comparison Content
              Flexible(
                child: SingleChildScrollView(
                  child: isMobile 
                    ? _buildMobileComparison(context)
                    : _buildDesktopComparison(),
                ),
              ),
              
              // Footer Actions
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to purchase or details
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Select Best Plan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  Widget _buildDesktopComparison() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Features Column
          Container(
            width: 180,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                _buildFeatureHeader('Features'),
                _buildFeatureRow('Provider', Icons.business),
                _buildFeatureRow('Sum Assured', Icons.account_balance_wallet),
                _buildFeatureRow('Premium/Year', Icons.payments),
                _buildFeatureRow('Entry Age', Icons.person_outline),
                _buildFeatureRow('Policy Term', Icons.timer),
                _buildFeatureRow('Claim Ratio', Icons.verified),
                _buildFeatureRow('Cashless Hospitals', Icons.local_hospital),
                _buildFeatureRow('Waiting Period', Icons.hourglass_empty),
                _buildFeatureRow('Renewability', Icons.refresh),
              ],
            ),
          ),
          
          // Plans Columns
          Expanded(
            child: Row(
              children: policies.map((policy) => Expanded(
                child: _buildPlanColumn(policy),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileComparison(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: policies.map((policy) => _buildMobilePlanCard(context, policy)).toList(),
      ),
    );
  }

  Widget _buildPlanColumn(InsurancePolicy policy) {
    final isFirst = policies.first == policy;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: isFirst ? BorderSide.none : BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        children: [
          _buildPlanHeader(policy),
          _buildPlanValue(policy.provider, isHighlighted: false),
          _buildPlanValue('₹${(policy.sumAssured / 100000).toStringAsFixed(0)}L', isHighlighted: true),
          _buildPlanValue('₹${policy.premium.toStringAsFixed(0)}', isHighlighted: true, isPrice: true),
          _buildPlanValue('18-65 Years', isHighlighted: false),
          _buildPlanValue('1-30 Years', isHighlighted: false),
          _buildPlanValue('${policy.claimSettlementRatio ?? "95"}%', isHighlighted: policy.claimSettlementRatio != null && policy.claimSettlementRatio! > 95),
          _buildPlanValue('5000+', isHighlighted: true),
          _buildPlanValue('30 Days', isHighlighted: false),
          _buildPlanValue('Lifetime', isHighlighted: true),
        ],
      ),
    );
  }

  Widget _buildMobilePlanCard(BuildContext context, InsurancePolicy policy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  policy.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  policy.provider,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${policy.premium.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'per year',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Recommended',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildMobileDetailRow('Sum Assured', '₹${(policy.sumAssured / 100000).toStringAsFixed(0)}L', Icons.account_balance_wallet),
                const Divider(height: 24),
                _buildMobileDetailRow('Entry Age', '18-65 Years', Icons.person_outline),
                const Divider(height: 24),
                _buildMobileDetailRow('Policy Term', '1-30 Years', Icons.timer),
                const Divider(height: 24),
                _buildMobileDetailRow('Claim Ratio', '${policy.claimSettlementRatio ?? "95"}%', Icons.verified),
                const Divider(height: 24),
                _buildMobileDetailRow('Cashless Hospitals', '5000+', Icons.local_hospital),
                const Divider(height: 24),
                _buildMobileDetailRow('Waiting Period', '30 Days', Icons.hourglass_empty),
                const Divider(height: 24),
                _buildMobileDetailRow('Renewability', 'Lifetime', Icons.refresh),
              ],
            ),
          ),
          
          // Action Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Select This Plan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[400]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureHeader(String title) {
    return Container(
      height: 80,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String label, IconData icon) {
    return Container(
      height: 56,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[500]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanHeader(InsurancePolicy policy) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            policy.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: policy.premium < 10000 ? const Color(0xFFD1FAE5) : Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              policy.premium < 10000 ? 'Best Value' : 'Popular',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: policy.premium < 10000 ? const Color(0xFF059669) : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanValue(String value, {required bool isHighlighted, bool isPrice = false}) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.primary.withValues(alpha: 0.02) : null,
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!),
        ),
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isPrice ? 16 : 14,
          fontWeight: isPrice || isHighlighted ? FontWeight.w600 : FontWeight.normal,
          color: isPrice ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
    );
  }
}
