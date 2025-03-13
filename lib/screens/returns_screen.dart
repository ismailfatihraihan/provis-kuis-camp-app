import 'package:flutter/material.dart';
import '../models/transaction.dart';

class ReturnsScreen extends StatefulWidget {
  const ReturnsScreen({super.key});

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  int _currentStep = 0;
  final List<Transaction> _returnsEligible = [
  // Use the transaction with ID TRX-004 which has inUse status
  sampleTransactions.firstWhere((t) => t.id == 'TRX-004'),
];
  
  Transaction? _selectedTransaction = sampleTransactions.firstWhere((t) => t.id == 'TRX-004');
  String _returnMethod = 'Drop-off';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  String _itemCondition = 'Good';
  String _additionalNotes = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengembalian'),
      ),
      body: _returnsEligible.isEmpty
          ? _buildEmptyState()
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep == 0 && _selectedTransaction == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select an order to return'),
                    ),
                  );
                  return;
                }
                
                setState(() {
                  if (_currentStep < 3) {
                    _currentStep++;
                  } else {
                    // Process the return
                    _processReturn();
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep--;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26A69A), // Updated to teal
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          _currentStep == 3 ? 'Submit Return' : 'Continue',
                        ),
                      ),
                      if (_currentStep > 0) ...[
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                      ],
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Select Order'),
                  content: _buildOrderSelection(),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text('Return Method'),
                  content: _buildReturnMethod(),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text('Item Condition'),
                  content: _buildItemCondition(),
                  isActive: _currentStep >= 2,
                ),
                Step(
                  title: const Text('Confirm Return'),
                  content: _buildConfirmation(),
                  isActive: _currentStep >= 3,
                ),
              ],
            ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_return_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No items to return',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any active rentals to return',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF26A69A), // Updated to teal
              foregroundColor: Colors.white,
            ),
            child: const Text('Explore Items'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the order you want to return:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          _returnsEligible.length,
          (index) => _buildOrderCard(
            _returnsEligible[index],
            isSelected: _selectedTransaction?.id == _returnsEligible[index].id,
            onTap: () {
              setState(() {
                _selectedTransaction = _returnsEligible[index];
              });
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildOrderCard(
    Transaction transaction, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF26A69A) : Colors.transparent, // Updated to teal
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order ${transaction.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF26A69A), // Updated to teal
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Rental Period: ${_formatDate(transaction.rentalStart)} - ${_formatDate(transaction.rentalEnd)}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              ...List.generate(
                transaction.items.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          transaction.items[index].item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.items[index].item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${transaction.items[index].quantity}x for ${transaction.items[index].days} days',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildReturnMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How would you like to return the items?',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        // Return method selection
        _buildSelectionCard(
          title: 'Drop-off',
          description: 'Return items to our store location',
          icon: Icons.store,
          isSelected: _returnMethod == 'Drop-off',
          onTap: () {
            setState(() {
              _returnMethod = 'Drop-off';
            });
          },
        ),
        
        const SizedBox(height: 12),
        
        _buildSelectionCard(
          title: 'Pickup',
          description: 'We\'ll pick up the items from your location',
          icon: Icons.local_shipping,
          isSelected: _returnMethod == 'Pickup',
          onTap: () {
            setState(() {
              _returnMethod = 'Pickup';
            });
          },
        ),
        
        const SizedBox(height: 24),
        
        // Date and time selection
        const Text(
          'Select preferred date and time:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        
        // Date picker
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 14)),
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${_formatDate(_selectedDate)}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Time picker
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime,
            );
            if (picked != null && picked != _selectedTime) {
              setState(() {
                _selectedTime = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time: ${_selectedTime.format(context)}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
        
        if (_returnMethod == 'Pickup') ...[
          const SizedBox(height: 24),
          const Text(
            'Pickup Address:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          _buildAddressCard(),
        ],
      ],
    );
  }
  
  Widget _buildItemCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How would you rate the condition of the items?',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        // Condition selection
        _buildConditionOption(
          'Excellent',
          'Items are in perfect condition, like new',
          Icons.sentiment_very_satisfied,
          _itemCondition == 'Excellent',
          () {
            setState(() {
              _itemCondition = 'Excellent';
            });
          },
        ),
        
        const SizedBox(height: 12),
        
        _buildConditionOption(
          'Good',
          'Items show minor signs of use but function perfectly',
          Icons.sentiment_satisfied,
          _itemCondition == 'Good',
          () {
            setState(() {
              _itemCondition = 'Good';
            });
          },
        ),
        
        const SizedBox(height: 12),
        
        _buildConditionOption(
          'Fair',
          'Items show wear and tear but are still functional',
          Icons.sentiment_neutral,
          _itemCondition == 'Fair',
          () {
            setState(() {
              _itemCondition = 'Fair';
            });
          },
        ),
        
        const SizedBox(height: 12),
        
        _buildConditionOption(
          'Poor',
          'Items are damaged or not functioning properly',
          Icons.sentiment_dissatisfied,
          _itemCondition == 'Poor',
          () {
            setState(() {
              _itemCondition = 'Poor';
            });
          },
        ),
        
        const SizedBox(height: 24),
        
        // Additional notes
        const Text(
          'Additional Notes (Optional):',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        
        TextField(
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe any issues or damage to the items...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _additionalNotes = value;
            });
          },
        ),
        
        const SizedBox(height: 16),
        
        // Photo upload option
        OutlinedButton.icon(
          onPressed: () {
            // Photo upload functionality would go here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Photo upload feature not implemented in this demo'),
              ),
            );
          },
          icon: const Icon(Icons.camera_alt),
          label: const Text('Add Photos (Optional)'),
        ),
      ],
    );
  }
  
  Widget _buildConfirmation() {
    if (_selectedTransaction == null) {
      return const Center(
        child: Text('Please select an order to return'),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Return Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Order details
        _buildSummaryItem(
          'Order ID:',
          _selectedTransaction!.id,
        ),
        
        _buildSummaryItem(
          'Return Method:',
          _returnMethod,
        ),
        
        _buildSummaryItem(
          'Date & Time:',
          '${_formatDate(_selectedDate)} at ${_selectedTime.format(context)}',
        ),
        
        _buildSummaryItem(
          'Item Condition:',
          _itemCondition,
        ),
        
        if (_additionalNotes.isNotEmpty)
          _buildSummaryItem(
            'Notes:',
            _additionalNotes,
          ),
        
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        
        // Items being returned
        const Text(
          'Items Being Returned:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        
        ...List.generate(
          _selectedTransaction!.items.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _selectedTransaction!.items[index].item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedTransaction!.items[index].item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${_selectedTransaction!.items[index].quantity}x',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        
        // Terms and conditions
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: const Color(0xFF26A69A), // Updated to teal
            ),
            const Expanded(
              child: Text(
                'I confirm that the information provided is accurate and I agree to the return policy.',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSelectionCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF26A69A) : Colors.transparent, // Updated to teal
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF26A69A).withOpacity(0.1) // Updated to teal
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? const Color(0xFF26A69A) : Colors.grey[600], // Updated to teal
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Radio(
                value: title,
                groupValue: _returnMethod,
                onChanged: (value) {
                  setState(() {
                    _returnMethod = value.toString();
                  });
                },
                activeColor: const Color(0xFF26A69A), // Updated to teal
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildConditionOption(
    String title,
    String description,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF26A69A) : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF26A69A).withOpacity(0.1)
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? const Color(0xFF26A69A) : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Radio(
                value: title,
                groupValue: _itemCondition,
                onChanged: (value) {
                  setState(() {
                    _itemCondition = value.toString();
                  });
                },
                activeColor: const Color(0xFF26A69A),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAddressCard() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 8),
                const Text(
                  'Home',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Change address
                  },
                  child: const Text('Change'),
                ),
              ],
            ),
            const Text('John Doe'),
            const Text('123 Camping Street'),
            const Text('Jakarta, 12345'),
            const Text('(+62) 812-3456-7890'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _processReturn() {
    // In a real app, this would process the return request
    // and update the database
    
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Return Submitted'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF26A69A), // Updated to teal
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your return request has been submitted successfully!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _returnMethod == 'Pickup'
                  ? 'We will pick up your items on ${_formatDate(_selectedDate)} at ${_selectedTime.format(context)}.'
                  : 'Please drop off your items at our store on ${_formatDate(_selectedDate)} at ${_selectedTime.format(context)}.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/transactions');
            },
            child: const Text('View Orders'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF26A69A), // Updated to teal
              foregroundColor: Colors.white,
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

