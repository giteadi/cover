import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ClaimAssistanceScreen extends StatefulWidget {
  const ClaimAssistanceScreen({super.key});

  @override
  State<ClaimAssistanceScreen> createState() => _ClaimAssistanceScreenState();
}

class _ClaimAssistanceScreenState extends State<ClaimAssistanceScreen> {
  final _formKey = GlobalKey<FormState>();
  String claimType = 'cashless';
  String policyNumber = '';
  String hospitalName = '';
  String dateOfAdmission = '';
  String reason = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'Claim Assistance',
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmergencyCard(),
              const SizedBox(height: 24),
              _buildStepsSection(),
              const SizedBox(height: 24),
              _buildClaimForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDC2626), Color(0xFFB91C1C)],
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.emergency, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '24x7 Claim Support',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Call us for emergency assistance',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Color(0xFFDC2626)),
                  SizedBox(width: 8),
                  Text(
                    '1800-123-4567',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsSection() {
    final steps = [
      {'icon': Icons.medical_services, 'title': 'Inform Hospital', 'desc': 'Show your insurance card'},
      {'icon': Icons.document_scanner, 'title': 'Submit Documents', 'desc': 'ID proof & medical reports'},
      {'icon': Icons.verified, 'title': 'Get Approval', 'desc': 'Cashless approval in 30 mins'},
      {'icon': Icons.check_circle, 'title': 'Treatment', 'desc': 'Hospital settles with insurer'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cashless Claim Process',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: steps.asMap().entries.map((entry) {
            final isLast = entry.key == steps.length - 1;
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(entry.value['icon'] as IconData, color: AppColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.value['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.value['desc'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    const Icon(Icons.chevron_right, color: AppColors.border, size: 20),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildClaimForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Intimate New Claim',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _buildClaimTypeSelector(),
            const SizedBox(height: 20),
            _buildTextField('Policy Number', Icons.confirmation_number, (v) => policyNumber = v),
            const SizedBox(height: 16),
            _buildTextField('Hospital Name', Icons.local_hospital, (v) => hospitalName = v),
            const SizedBox(height: 16),
            _buildTextField('Date of Admission', Icons.calendar_today, (v) => dateOfAdmission = v),
            const SizedBox(height: 16),
            _buildTextField('Reason for Treatment', Icons.note, (v) => reason = v, maxLines: 3),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitClaim,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit Claim Request',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => claimType = 'cashless'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: claimType == 'cashless' ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: claimType == 'cashless' ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: claimType == 'cashless' ? Colors.white : AppColors.textSecondary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cashless',
                    style: TextStyle(
                      color: claimType == 'cashless' ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => claimType = 'reimbursement'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: claimType == 'reimbursement' ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: claimType == 'reimbursement' ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.money,
                    color: claimType == 'reimbursement' ? Colors.white : AppColors.textSecondary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reimbursement',
                    style: TextStyle(
                      color: claimType == 'reimbursement' ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, IconData icon, Function(String) onChanged, {int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: AppColors.background,
      ),
      maxLines: maxLines,
      onChanged: onChanged,
      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
    );
  }

  void _submitClaim() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Claim Submitted'),
          content: const Text('Your claim request has been submitted. Our team will contact you within 24 hours.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
