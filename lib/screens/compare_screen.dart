import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/mock_data.dart';
import '../models/policy.dart';
import 'detailed_comparison_dialog.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  List<InsurancePolicy> policies = [];
  List<InsurancePolicy> compareList = [];

  @override
  void initState() {
    super.initState();
    policies = [
      ...MockData.healthPolicies,
      ...MockData.lifePolicies,
      ...MockData.motorPolicies,
    ];
  }

  void toggleCompare(InsurancePolicy policy) {
    setState(() {
      if (compareList.contains(policy)) {
        compareList.remove(policy);
      } else if (compareList.length < 3) {
        compareList.add(policy);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can compare up to 3 plans only')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'Compare Plans',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: policies.length,
        itemBuilder: (context, index) {
          final policy = policies[index];
          final isSelected = compareList.contains(policy);
          return _PolicySelectCard(
            policy: policy,
            isSelected: isSelected,
            onToggle: () => toggleCompare(policy),
          );
        },
      ),
      bottomNavigationBar: compareList.isNotEmpty ? _buildCompareButton() : null,
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 16,
          columns: [
            const DataColumn(label: Text('Feature')),
            ...compareList.map((p) => DataColumn(
              label: SizedBox(
                width: 100,
                child: Text(
                  p.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('Provider')),
              ...compareList.map((p) => DataCell(Text(p.provider))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Sum Assured')),
              ...compareList.map((p) => DataCell(Text('₹${(p.sumAssured / 100000).toStringAsFixed(0)}L'))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Premium')),
              ...compareList.map((p) => DataCell(Text('₹${p.premium.toStringAsFixed(0)}'))),
            ]),
            if (compareList.any((p) => p.claimSettlementRatio != null))
              DataRow(cells: [
                const DataCell(Text('Claim Ratio')),
                ...compareList.map((p) => DataCell(Text('${p.claimSettlementRatio ?? "-"}%'))),
              ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCompareButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${compareList.length} plan${compareList.length > 1 ? 's' : ''} selected',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => DetailedComparisonDialog(
                    policies: compareList,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('View Comparison'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicySelectCard extends StatelessWidget {
  final InsurancePolicy policy;
  final bool isSelected;
  final VoidCallback onToggle;

  const _PolicySelectCard({
    required this.policy,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (_) => onToggle(),
            activeColor: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  policy.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${policy.provider} • ₹${(policy.sumAssured / 100000).toStringAsFixed(0)}L Cover',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${policy.premium.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
