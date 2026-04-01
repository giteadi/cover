import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'view_quotes_screen.dart';

class InsuranceFormScreen extends StatefulWidget {
  final String category;
  
  const InsuranceFormScreen({super.key, required this.category});
  
  @override
  State<InsuranceFormScreen> createState() => _InsuranceFormScreenState();
}

class _InsuranceFormScreenState extends State<InsuranceFormScreen> {
  String selectedGender = 'Male';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String _age = '';
  
  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _calculateAge(String dob) {
    String formattedDob = _formatDateWithSlashes(dob);
    
    if (formattedDob != dob && formattedDob != _dobController.text) {
      final cursorPosition = _dobController.selection.start;
      _dobController.value = TextEditingValue(
        text: formattedDob,
        selection: TextSelection.collapsed(
          offset: cursorPosition + (formattedDob.length - dob.length),
        ),
      );
    }
    
    dob = formattedDob;
    
    if (dob.length == 10) {
      try {
        final parts = dob.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          
          final birthDate = DateTime(year, month, day);
          final today = DateTime.now();
          
          int age = today.year - birthDate.year;
          if (today.month < birthDate.month || 
              (today.month == birthDate.month && today.day < birthDate.day)) {
            age--;
          }
          
          setState(() {
            _age = '$age Years';
          });
        }
      } catch (e) {
        setState(() {
          _age = '';
        });
      }
    } else {
      setState(() {
        _age = '';
      });
    }
  }

  String _formatDateWithSlashes(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    
    StringBuffer result = StringBuffer();
    
    for (int i = 0; i < digitsOnly.length && i < 8; i++) {
      if (i == 2 || i == 4) {
        result.write('/');
      }
      result.write(digitsOnly[i]);
    }
    
    return result.toString();
  }
  
  // Category-specific data
  Map<String, dynamic> get _categoryData {
    final data = {
      'Term Insurance': {
        'description': 'Term Insurance is a legal contract between a policyholder and an insurance company. In a term insurance policy, the insurance company promises to pay a sum of money to the policyholder\'s loved ones if the policyholder dies during a specified period.',
        'benefits': [
          {'icon': Icons.verified, 'text': 'Get ₹1 Crore Coverage at Affordable Premiums'},
          {'icon': Icons.trending_up, 'text': 'High Sum Assured at Low Premium Rates'},
          {'icon': Icons.family_restroom, 'text': 'Financial Security for Your Family'},
          {'icon': Icons.receipt_long, 'text': 'Tax Benefits under Section 80C & 10D'},
        ],
        'coverageAmount': '₹1 Crore',
        'startingPrice': '₹409/month',
        'stats': {'rating': '4.8', 'policies': '6.29 Crore', 'users': '13.2 Crore', 'partners': '53'},
        'showGender': true,
        'showDob': true,
        'buttonText': 'View Term Quotes',
      },
      'Life Insurance': {
        'description': 'Life Insurance provides financial protection to your family in case of an unfortunate event. It ensures that your loved ones can maintain their lifestyle and meet their financial goals even in your absence.',
        'benefits': [
          {'icon': Icons.verified, 'text': 'Complete Life Coverage with Maturity Benefits'},
          {'icon': Icons.savings, 'text': 'Savings Component with Insurance Protection'},
          {'icon': Icons.paid, 'text': 'Guaranteed Returns on Investment'},
          {'icon': Icons.receipt_long, 'text': 'Tax Benefits on Premiums & Returns'},
        ],
        'coverageAmount': '₹50 Lakhs',
        'startingPrice': '₹2,000/month',
        'stats': {'rating': '4.7', 'policies': '5.8 Crore', 'users': '11 Crore', 'partners': '48'},
        'showGender': true,
        'showDob': true,
        'buttonText': 'View Life Plans',
      },
      'Health Insurance': {
        'description': 'Health Insurance covers medical expenses incurred due to illnesses, injuries, or accidents. It ensures that you get the best medical treatment without worrying about the costs.',
        'benefits': [
          {'icon': Icons.local_hospital, 'text': 'Cashless Treatment at 10,000+ Hospitals'},
          {'icon': Icons.medication, 'text': 'Coverage for Pre & Post Hospitalization'},
          {'icon': Icons.healing, 'text': 'Annual Health Check-ups Included'},
          {'icon': Icons.add_circle, 'text': 'No Claim Bonus up to 100%'},
        ],
        'coverageAmount': '₹10 Lakhs',
        'startingPrice': '₹500/month',
        'stats': {'rating': '4.6', 'policies': '4.2 Crore', 'users': '8.5 Crore', 'partners': '42'},
        'showGender': true,
        'showDob': true,
        'buttonText': 'View Health Plans',
      },
      'Car Insurance': {
        'description': 'Car Insurance protects your vehicle against damages caused by accidents, theft, natural calamities, or third-party liabilities. Drive worry-free with comprehensive coverage.',
        'benefits': [
          {'icon': Icons.directions_car, 'text': 'Cashless Repairs at 7,500+ Garages'},
          {'icon': Icons.shield, 'text': 'Own Damage & Third-Party Coverage'},
          {'icon': Icons.support_agent, 'text': '24x7 Roadside Assistance'},
          {'icon': Icons.bolt, 'text': 'Instant Policy Issuance'},
        ],
        'coverageAmount': 'IDV upto ₹15 Lakhs',
        'startingPrice': '₹2,094/year',
        'stats': {'rating': '4.5', 'policies': '3.8 Crore', 'users': '6.2 Crore', 'partners': '38'},
        'showGender': false,
        'showDob': false,
        'buttonText': 'View Car Plans',
      },
      'Bike Insurance': {
        'description': 'Two Wheeler Insurance provides financial protection for your bike/scooter against damages, theft, and third-party liabilities. Ride safe with complete coverage.',
        'benefits': [
          {'icon': Icons.two_wheeler, 'text': 'Coverage for All Bike Types'},
          {'icon': Icons.shield, 'text': 'Third-Party & Own Damage Cover'},
          {'icon': Icons.support_agent, 'text': '24x7 Roadside Assistance'},
          {'icon': Icons.bolt, 'text': 'Instant Policy in 2 Minutes'},
        ],
        'coverageAmount': 'IDV upto ₹3 Lakhs',
        'startingPrice': '₹538/year',
        'stats': {'rating': '4.4', 'policies': '2.5 Crore', 'users': '4.8 Crore', 'partners': '35'},
        'showGender': false,
        'showDob': false,
        'buttonText': 'View Bike Plans',
      },
      'Travel Insurance': {
        'description': 'Travel Insurance covers medical emergencies, trip cancellations, lost baggage, and other unforeseen events during your domestic or international travels.',
        'benefits': [
          {'icon': Icons.flight, 'text': 'Medical Emergency Coverage Abroad'},
          {'icon': Icons.luggage, 'text': 'Lost Baggage & Passport Protection'},
          {'icon': Icons.cancel, 'text': 'Trip Cancellation & Curtailment Cover'},
          {'icon': Icons.support_agent, 'text': '24x7 Global Assistance'},
        ],
        'coverageAmount': r'$500,000',
        'startingPrice': '₹200/day',
        'stats': {'rating': '4.3', 'policies': '1.2 Crore', 'users': '2.5 Crore', 'partners': '28'},
        'showGender': true,
        'showDob': true,
        'buttonText': 'View Travel Plans',
      },
      'Home Insurance': {
        'description': 'Home Insurance protects your home and its contents against natural disasters, theft, fire, and other risks. Secure your biggest investment with comprehensive coverage.',
        'benefits': [
          {'icon': Icons.home, 'text': 'Building & Contents Coverage'},
          {'icon': Icons.local_fire_department, 'text': 'Fire & Natural Disaster Protection'},
          {'icon': Icons.warning, 'text': 'Theft & Burglary Coverage'},
          {'icon': Icons.electrical_services, 'text': 'Electrical & Plumbing Damage Cover'},
        ],
        'coverageAmount': '₹50 Lakhs',
        'startingPrice': '₹1,200/year',
        'stats': {'rating': '4.2', 'policies': '80 Lakh', 'users': '1.5 Crore', 'partners': '25'},
        'showGender': false,
        'showDob': false,
        'buttonText': 'View Home Plans',
      },
    };
    
    return data[widget.category] ?? data['Term Insurance']!;
  }
  
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final categoryData = _categoryData;
    
    return Scaffold(
      backgroundColor: Colors.white,
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
          if (!isMobile) ...[
            TextButton(
              onPressed: () {},
              child: const Text('Claim', style: TextStyle(color: AppColors.textPrimary)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Get The App', style: TextStyle(color: AppColors.textPrimary)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Sales: 1800-419-7713',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Sign In'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 40),
          child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLeftContent(categoryData),
                  const SizedBox(height: 32),
                  _buildRightFormCard(isMobile, categoryData),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildLeftContent(categoryData)),
                  const SizedBox(width: 60),
                  SizedBox(width: 420, child: _buildRightFormCard(isMobile, categoryData)),
                ],
              ),
        ),
      ),
    );
  }
  
  Widget _buildLeftContent(Map<String, dynamic> data) {
    final benefits = data['benefits'] as List<Map<String, dynamic>>;
    final stats = data['stats'] as Map<String, String>;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb
        Row(
          children: [
            Text(
              'Home',
              style: TextStyle(fontSize: 12, color: Colors.blue[600]),
            ),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
            Text(
              widget.category,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Heading
        Text(
          widget.category,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        
        // Description
        Text(
          data['description'],
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        
        // Green Benefits Box
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC8E6C9)),
          ),
          child: Row(
            children: [
              // Left side of green box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Protection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Benefits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Right side bullet points
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: benefits.map((benefit) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildBulletPoint(benefit['icon'] as IconData, benefit['text'] as String),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        // Stats Row
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn(stats['rating']!, 'Rated', true),
              Container(height: 40, width: 1, color: Colors.grey[300]),
              _buildStatColumn(stats['policies']!, 'Policies Sold', false),
              Container(height: 40, width: 1, color: Colors.grey[300]),
              _buildStatColumn(stats['users']!, 'Registered Users', false),
              Container(height: 40, width: 1, color: Colors.grey[300]),
              _buildStatColumn(stats['partners']!, 'Partners', false),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildBulletPoint(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatColumn(String value, String label, bool isRated) {
    return Column(
      children: [
        if (isRated) ...[
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Color(0xFFFFB300), size: 20),
            ],
          ),
        ] else ...[
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildRightFormCard(bool isMobile, Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tabs
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        widget.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Form Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tagline
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      children: [
                        TextSpan(text: 'Get ${data['coverageAmount']} coverage starting from '),
                        TextSpan(
                          text: '${data['startingPrice']}*',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Gender Selection (conditional)
                if (data['showGender']) ...[
                  Row(
                    children: [
                      _buildRadioGender('Male'),
                      const SizedBox(width: 24),
                      _buildRadioGender('Female'),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                
                // Name Field
                _buildFormTextField(
                  icon: Icons.person_outline,
                  hint: 'Your Name',
                  controller: _nameController,
                ),
                const SizedBox(height: 12),
                
                // DOB Field (conditional)
                if (data['showDob']) ...[
                  _buildFormTextField(
                    icon: Icons.calendar_today,
                    hint: 'Date of Birth (DD/MM/YYYY)',
                    controller: _dobController,
                    onChanged: _calculateAge,
                    suffix: _age.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _age,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : null,
                  ),
                  const SizedBox(height: 12),
                ],
                
                // Mobile Field with Country Code
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: Colors.grey[300]!)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.flag, size: 20, color: Colors.orange),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '+91',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // View Quotes Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.isNotEmpty 
                          ? _nameController.text 
                          : 'User';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewQuotesScreen(
                            category: widget.category,
                            name: name,
                            gender: selectedGender,
                            age: _age.isNotEmpty ? _age.replaceAll(' Years', '') : '30',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      data['buttonText'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Terms text
                Center(
                  child: Text(
                    'By clicking on "${data['buttonText']}" you agree to our Privacy Policy and Terms of use',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // WhatsApp Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified, size: 14, color: Colors.green[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Get Updates on WhatsApp',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 24,
                      child: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.green,
                        activeTrackColor: Colors.green[100],
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
  
  Widget _buildRadioGender(String gender) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF1976D2) : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
              ? Container(
                  margin: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1976D2),
                  ),
                )
              : null,
          ),
          const SizedBox(width: 8),
          Text(
            gender,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? AppColors.textPrimary : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFormTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    Function(String)? onChanged,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(icon, size: 20, color: Colors.grey[500]),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                suffixIcon: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
