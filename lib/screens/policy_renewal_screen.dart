import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class PolicyRenewalScreen extends StatefulWidget {
  final String renewalType;
  final String title;
  final IconData icon;
  final Color themeColor;
  final List<Map<String, dynamic>> additionalFields;

  const PolicyRenewalScreen({
    super.key,
    required this.renewalType,
    required this.title,
    required this.icon,
    required this.themeColor,
    this.additionalFields = const [],
  });

  @override
  State<PolicyRenewalScreen> createState() => _PolicyRenewalScreenState();
}

class _PolicyRenewalScreenState extends State<PolicyRenewalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _policyNumberController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final Map<String, TextEditingController> _additionalControllers = {};
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    for (var field in widget.additionalFields) {
      if (field['type'] == 'text' || field['type'] == 'date') {
        _additionalControllers[field['key']] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    _policyNumberController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    for (var controller in _additionalControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          _showRenewalOptions();
        }
      });
    }
  }

  void _showRenewalOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${widget.title} - Renewal Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOptionCard('Quick Renewal', 'Auto-renew with existing details', Icons.flash_on, Colors.orange),
            const SizedBox(height: 12),
            _buildOptionCard('Modify & Renew', 'Update coverage and renew', Icons.edit, Colors.blue),
            const SizedBox(height: 12),
            _buildOptionCard('Download Policy', 'Get your current policy document', Icons.download, Colors.green),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title selected - Processing...')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(widget.icon, color: widget.themeColor, size: 28),
            const SizedBox(width: 12),
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 200, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.themeColor.withOpacity(0.1),
                      widget.themeColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: widget.themeColor.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Icon(widget.icon, size: 48, color: widget.themeColor),
                    const SizedBox(height: 16),
                    Text(
                      'Renew Your ${widget.renewalType} Policy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.themeColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your policy details to check renewal options and premiums',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Form Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Policy Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.themeColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Policy Number
                      _buildTextField(
                        controller: _policyNumberController,
                        label: 'Policy Number',
                        hint: 'Enter your policy number',
                        icon: Icons.confirmation_number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Policy number is required';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Mobile Number
                      _buildTextField(
                        controller: _mobileController,
                        label: 'Mobile Number',
                        hint: 'Enter registered mobile number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Mobile number is required';
                          if (value!.length < 10) return 'Enter valid mobile number';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        hint: 'Enter registered email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Email is required';
                          if (!value!.contains('@')) return 'Enter valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Policy Expiry Date
                      _buildDateField(
                        controller: _dateController,
                        label: 'Policy Expiry Date',
                        hint: 'Select expiry date',
                        icon: Icons.calendar_today,
                      ),

                      // Additional Fields based on policy type
                      ...widget.additionalFields.map((field) {
                        if (field['type'] == 'text') {
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _additionalControllers[field['key']]!,
                                label: field['label'],
                                hint: field['hint'],
                                icon: field['icon'],
                                validator: field['required'] 
                                  ? (value) => value?.isEmpty ?? true ? '${field['label']} is required' : null
                                  : null,
                              ),
                            ],
                          );
                        } else if (field['type'] == 'date') {
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              _buildDateField(
                                controller: _additionalControllers[field['key']]!,
                                label: field['label'],
                                hint: field['hint'],
                                icon: field['icon'],
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }).toList(),

                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.themeColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Check Renewal Options',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Benefits Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Benefits of Renewing Online',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBenefitItem(Icons.timer, 'Renew in 2 minutes', 'Quick and hassle-free process'),
                    _buildBenefitItem(Icons.local_offer, 'No paperwork needed', '100% digital process'),
                    _buildBenefitItem(Icons.security, 'Instant policy issuance', 'Get policy immediately'),
                    _buildBenefitItem(Icons.support_agent, '24/7 support', 'Always here to help'),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: widget.themeColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.themeColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          controller.text = '${date.day}/${date.month}/${date.year}';
        }
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: widget.themeColor),
        suffixIcon: Icon(Icons.arrow_drop_down, color: widget.themeColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.themeColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.themeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: widget.themeColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
}
