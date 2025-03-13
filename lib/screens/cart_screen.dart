import 'package:flutter/material.dart';
import '../models/camping_item.dart';
import '../models/transaction.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Mock data - in a real app this would come from a cart state
  final List<CartItem> _cartItems = [
    CartItem(
      item: featuredItems[0],
      quantity: 1,
      days: 3,
    ),
    CartItem(
      item: popularItems[1],
      quantity: 2,
      days: 3,
    ),
  ];
  
  double _subtotal = 0;
  final double _deliveryFee = 10.0;
  
  @override
  void initState() {
    super.initState();
    _calculateSubtotal();
  }
  
  void _calculateSubtotal() {
    _subtotal = 0;
    for (final item in _cartItems) {
      _subtotal += item.totalPrice;
    }
  }
  
  void _updateQuantity(int index, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = CartItem(
          item: _cartItems[index].item,
          quantity: quantity,
          days: _cartItems[index].days,
        );
      }
      _calculateSubtotal();
    });
  }
  
  void _updateDays(int index, int days) {
    setState(() {
      if (days <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = CartItem(
          item: _cartItems[index].item,
          quantity: _cartItems[index].quantity,
          days: days,
        );
      }
      _calculateSubtotal();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final double total = _subtotal + (_cartItems.isEmpty ? 0 : _deliveryFee);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text('Are you sure you want to remove all items from your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _cartItems.clear();
                            _calculateSubtotal();
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cart cleared'),
                            ),
                          );
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final cartItem = _cartItems[index];
                      return _buildCartItem(cartItem, index);
                    },
                  ),
                ),
                _buildOrderSummary(total),
              ],
            ),
    );
  }
  
  Widget _buildCartItem(CartItem cartItem, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            
            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${cartItem.item.price.toStringAsFixed(0)}k/day',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Quantity and days selection
                  Row(
                    children: [
                      // Quantity selector
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildCounterButton(
                                icon: Icons.remove,
                                onPressed: () => _updateQuantity(
                                  index,
                                  cartItem.quantity - 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildCounterButton(
                                icon: Icons.add,
                                onPressed: () => _updateQuantity(
                                  index,
                                  cartItem.quantity + 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Days selector
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Days',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildCounterButton(
                                icon: Icons.remove,
                                onPressed: () => _updateDays(
                                  index,
                                  cartItem.days - 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  cartItem.days.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildCounterButton(
                                icon: Icons.add,
                                onPressed: () => _updateDays(
                                  index,
                                  cartItem.days + 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Remove button and total price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _updateQuantity(index, 0),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),
                Text(
                  'Rp ${cartItem.totalPrice.toStringAsFixed(0)}k',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderSummary(double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal'),
              Text('Rp ${_subtotal.toStringAsFixed(0)}k'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Fee'),
              Text('Rp ${_deliveryFee.toStringAsFixed(0)}k'),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Rp ${total.toStringAsFixed(0)}k',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _cartItems.isEmpty
                  ? null
                  : () {
                      // Navigate to checkout or show checkout sheet
                      _showCheckoutSheet(context, total);
                    },
              child: const Text('Proceed to Checkout'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showCheckoutSheet(BuildContext context, double total) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (_, controller) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Checkout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        // Rental period
                        _buildCheckoutSection(
                          'Rental Period',
                          [
                            _buildDateSelector(
                              'Start Date',
                              DateTime.now().add(const Duration(days: 2)),
                            ),
                            const SizedBox(height: 16),
                            _buildDateSelector(
                              'End Date',
                              DateTime.now().add(const Duration(days: 5)),
                            ),
                          ],
                        ),
                        
                        // Delivery address
                        _buildCheckoutSection(
                          'Delivery Address',
                          [
                            _buildAddressCard(),
                          ],
                        ),
                        
                        // Payment method
                        _buildCheckoutSection(
                          'Payment Method',
                          [
                            _buildPaymentMethodSelector(),
                          ],
                        ),
                        
                        // Special requests
                        _buildCheckoutSection(
                          'Special Requests (Optional)',
                          [
                            const TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: 'Any special requests or notes for delivery...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        
                        // Order summary
                        _buildCheckoutSection(
                          'Order Summary',
                          [
                            ...List.generate(
                              _cartItems.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${_cartItems[index].item.name} (${_cartItems[index].quantity} × ${_cartItems[index].days} days)',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      'Rp ${_cartItems[index].totalPrice.toStringAsFixed(0)}k',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal'),
                                Text('Rp ${_subtotal.toStringAsFixed(0)}k'),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delivery Fee'),
                                Text('Rp ${_deliveryFee.toStringAsFixed(0)}k'),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Rp ${total.toStringAsFixed(0)}k',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Process order and navigate to success page
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order placed successfully!'),
                          ),
                        );
                        Navigator.pushNamed(context, '/transactions');
                      },
                      child: const Text('Place Order'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  
  Widget _buildCheckoutSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
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
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildDateSelector(String label, DateTime initialDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            // Show date picker
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
                  '${initialDate.day}/${initialDate.month}/${initialDate.year}',
                ),
                const Icon(Icons.calendar_today, size: 16),
              ],
            ),
          ),
        ),
      ],
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
  
  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        _buildPaymentOption(
          'Credit Card',
          Icons.credit_card,
          true,
        ),
        const SizedBox(height: 8),
        _buildPaymentOption(
          'Bank Transfer',
          Icons.account_balance,
          false,
        ),
        const SizedBox(height: 8),
        _buildPaymentOption(
          'E-Wallet',
          Icons.account_balance_wallet,
          false,
        ),
      ],
    );
  }
  
  Widget _buildPaymentOption(String title, IconData icon, bool selected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? Theme.of(context).primaryColor : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: selected ? Theme.of(context).primaryColor : Colors.grey),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          if (selected)
            Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            ),
        ],
      ),
    );
  }
  
  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        constraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        padding: EdgeInsets.zero,
        splashRadius: 16,
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to your cart to proceed with rental',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Explore Items'),
          ),
        ],
      ),
    );
  }
}

