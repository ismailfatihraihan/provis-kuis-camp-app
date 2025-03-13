import 'camping_item.dart';

enum TransactionStatus {
  pending,
  confirmed,
  inUse,
  returned,
  completed,
  cancelled,
}

class Transaction {
  final String id;
  final List<CartItem> items;
  final DateTime rentalStart;
  final DateTime rentalEnd;
  final double totalPrice;
  final TransactionStatus status;
  final String? notes;

  Transaction({
    required this.id,
    required this.items,
    required this.rentalStart,
    required this.rentalEnd,
    required this.totalPrice,
    required this.status,
    this.notes,
  });
}

class CartItem {
  final CampingItem item;
  final int quantity;
  final int days;

  CartItem({
    required this.item,
    required this.quantity,
    required this.days,
  });

  double get totalPrice => item.price * quantity * days;
}


final List<Transaction> sampleTransactions = [
  Transaction(
    id: 'TRX-001',
    items: [
      CartItem(
        item: featuredItems[0],
        quantity: 1,
        days: 3,
      ),
      CartItem(
        item: featuredItems[1],
        quantity: 2,
        days: 3,
      ),
    ],
    rentalStart: DateTime.now().subtract(const Duration(days: 5)),
    rentalEnd: DateTime.now().subtract(const Duration(days: 2)),
    totalPrice: 69.0,
    status: TransactionStatus.completed,
  ),
  Transaction(
    id: 'TRX-002',
    items: [
      CartItem(
        item: popularItems[2],
        quantity: 1,
        days: 2,
      ),
    ],
    rentalStart: DateTime.now(),
    rentalEnd: DateTime.now().add(const Duration(days: 2)),
    totalPrice: 18.0,
    status: TransactionStatus.confirmed,
  ),
  Transaction(
    id: 'TRX-003',
    items: [
      CartItem(
        item: newestItems[0],
        quantity: 1,
        days: 5,
      ),
      CartItem(
        item: popularItems[0],
        quantity: 1,
        days: 5,
      ),
    ],
    rentalStart: DateTime.now().add(const Duration(days: 7)),
    rentalEnd: DateTime.now().add(const Duration(days: 12)),
    totalPrice: 62.5,
    status: TransactionStatus.pending,
    notes: 'Please provide items in clean condition',
  ),
  Transaction(
    id: 'TRX-004',
    items: [
      CartItem(
        item: featuredItems[2],
        quantity: 1,
        days: 4,
      ),
      CartItem(
        item: popularItems[1],
        quantity: 2,
        days: 4,
      ),
    ],
    rentalStart: DateTime.now().subtract(const Duration(days: 2)),
    rentalEnd: DateTime.now().add(const Duration(days: 2)),
    totalPrice: 72.0,
    status: TransactionStatus.inUse,
    notes: 'Please handle with care',
  ),
];
