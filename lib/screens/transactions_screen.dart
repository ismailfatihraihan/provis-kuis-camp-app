import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrdersList(
              context,
              sampleTransactions.where((t) => 
                t.status == TransactionStatus.pending || 
                t.status == TransactionStatus.confirmed || 
                t.status == TransactionStatus.inUse
              ).toList(),
            ),
            _buildOrdersList(
              context,
              sampleTransactions.where((t) => 
                t.status == TransactionStatus.completed || 
                t.status == TransactionStatus.returned
              ).toList(),
            ),
            _buildOrdersList(
              context,
              sampleTransactions.where((t) => 
                t.status == TransactionStatus.cancelled
              ).toList(),
              isEmptyList: true,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrdersList(BuildContext context, List<Transaction> transactions, {bool isEmptyList = false}) {
    if (isEmptyList || transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No orders found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your orders will appear here',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _buildOrderCard(context, transaction);
      },
    );
  }
  
  Widget _buildOrderCard(BuildContext context, Transaction transaction) {
    final statusColor = _getStatusColor(transaction.status);
    final statusText = _getStatusText(transaction.status);
    
    return Card(
      child: Column(
        children: [
          // Order header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ${transaction.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Rental Period: ${_formatDate(transaction.rentalStart)} - ${_formatDate(transaction.rentalEnd)}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Order items
          ...List.generate(
            transaction.items.length,
            (index) => Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Item image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      transaction.items[index].item.imageUrl,
                      width: 60,
                      height: 60,
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
                          transaction.items[index].item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
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
                  
                  // Item price
                  Text(
                    'Rp ${transaction.items[index].totalPrice.toStringAsFixed(0)}k',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const Divider(height: 1),
          
          // Order total and actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${transaction.totalPrice.toStringAsFixed(0)}k',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Order actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // View order details
                        },
                        child: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: transaction.status == TransactionStatus.pending
                            ? () {
                                // Cancel order
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Order cancelled'),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: transaction.status == TransactionStatus.pending
                              ? Colors.red
                              : null,
                        ),
                        child: Text(
                          _getActionButtonText(transaction.status),
                        ),
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
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.confirmed:
        return Colors.blue;
      case TransactionStatus.inUse:
        return Colors.purple;
      case TransactionStatus.returned:
        return Colors.amber;
      case TransactionStatus.completed:
        return Colors.green;
      case TransactionStatus.cancelled:
        return Colors.red;
    }
  }
  
  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.confirmed:
        return 'Confirmed';
      case TransactionStatus.inUse:
        return 'In Use';
      case TransactionStatus.returned:
        return 'Returned';
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.cancelled:
        return 'Cancelled';
    }
  }
  
  String _getActionButtonText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return 'Cancel';
      case TransactionStatus.confirmed:
        return 'Track';
      case TransactionStatus.inUse:
        return 'Return';
      case TransactionStatus.returned:
      case TransactionStatus.completed:
        return 'Reorder';
      case TransactionStatus.cancelled:
        return 'Reorder';
    }
  }
}

