import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  
  int _selectedPlan = 1; // 0: 7 days, 1: 30 days, 2: 90 days
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _boostPlans = [
    {'days': 7, 'price': 9.99, 'label': '7 Days'},
    {'days': 30, 'price': 29.99, 'label': '30 Days'},
    {'days': 90, 'price': 69.99, 'label': '90 Days', 'popular': true},
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isProcessing = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success!'),
            content: Text(
              'Your profile has been boosted for ${_boostPlans[_selectedPlan]['days']} days!',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boost Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.rocket_launch,
              size: 80,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Boost Your Profile',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            Text(
              'Get more visibility and stand out from other models',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // Benefits
            _buildBenefitItem('Priority in search results'),
            _buildBenefitItem('Featured badge on profile'),
            _buildBenefitItem('3x more profile views'),
            _buildBenefitItem('Higher job match rate'),
            
            const SizedBox(height: 32),
            
            Text(
              'Select Plan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Plans
            ...List.generate(_boostPlans.length, (index) {
              final plan = _boostPlans[index];
              final isSelected = _selectedPlan == index;
              final isPopular = plan['popular'] == true;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: isSelected ? 4 : 1,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : null,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPlan = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: _selectedPlan,
                          onChanged: (value) {
                            setState(() {
                              _selectedPlan = value!;
                            });
                          },
                          activeColor: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : null,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    plan['label'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.onPrimary
                                          : null,
                                    ),
                                  ),
                                  if (isPopular) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'POPULAR',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${plan['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)
                                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
            }),
            
            const SizedBox(height: 32),
            
            Text(
              'Payment Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Payment Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      hintText: '1234 5678 9012 3456',
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _cardHolderController,
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name',
                      hintText: 'John Doe',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card holder name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            hintText: '123',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Total
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${_boostPlans[_selectedPlan]['price'].toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Pay Button
            ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('COMPLETE PAYMENT'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
