import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'term_life_form_screen.dart';

class ConfirmDetailsDialog extends StatefulWidget {
  final String userName;
  
  const ConfirmDetailsDialog({super.key, required this.userName});

  @override
  State<ConfirmDetailsDialog> createState() => _ConfirmDetailsDialogState();
}

class _ConfirmDetailsDialogState extends State<ConfirmDetailsDialog> {
  String smokingStatus = 'No';
  String annualIncome = '3 Lac to 4.9 Lac';
  String occupationType = 'Self-Employed';
  String education = 'College graduate & above';

  final List<String> smokingOptions = ['No', 'Yes, occasionally', 'Yes, regularly'];
  final List<String> incomeOptions = [
    'Less than 3 Lac',
    '3 Lac to 4.9 Lac',
    '5 Lac to 7.9 Lac',
    '8 Lac to 9.9 Lac',
    '10 Lac to 14.9 Lac',
    '15 Lac to 19.9 Lac',
    '20 Lac & above'
  ];
  final List<String> occupationOptions = [
    'Salaried',
    'Self-Employed',
    'Business Owner',
    'Professional',
    'Retired',
    'Student',
    'Homemaker',
    'Other'
  ];
  final List<String> educationOptions = [
    'High School or below',
    'College graduate & above',
    'Post Graduate',
    'Doctorate'
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final width = isMobile ? MediaQuery.of(context).size.width * 0.9 : 800.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SingleChildScrollView(
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Illustration
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(40),
            color: const Color(0xFFF8FAFC),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.family_restroom,
                    size: 100,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Protect Your Family',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Secure their future with the right term insurance plan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right side - Form
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back, ${widget.userName}!',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'To view accurate quotes, please confirm your details below',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildDropdownField(
                  'Do you smoke or chew tobacco?',
                  smokingStatus,
                  smokingOptions,
                  (value) => setState(() => smokingStatus = value!),
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  'Your annual income',
                  annualIncome,
                  incomeOptions,
                  (value) => setState(() => annualIncome = value!),
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  'Your occupation type',
                  occupationType,
                  occupationOptions,
                  (value) => setState(() => occupationType = value!),
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  'Your Educational qualification',
                  education,
                  educationOptions,
                  (value) => setState(() => education = value!),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermLifeFormScreen(category: 'Term Life Insurance'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA580C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, ${widget.userName}!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Please confirm your details',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.family_restroom,
                size: 60,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildDropdownField(
            'Do you smoke or chew tobacco?',
            smokingStatus,
            smokingOptions,
            (value) => setState(() => smokingStatus = value!),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            'Your annual income',
            annualIncome,
            incomeOptions,
            (value) => setState(() => annualIncome = value!),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            'Your occupation type',
            occupationType,
            occupationOptions,
            (value) => setState(() => occupationType = value!),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            'Your Educational qualification',
            education,
            educationOptions,
            (value) => setState(() => education = value!),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermLifeFormScreen(category: 'Term Life Insurance'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEA580C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
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
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
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
