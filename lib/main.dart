import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/item_detail_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/promotions_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/returns_screen.dart'; // Add import for the new screen
import 'theme/app_theme.dart';

void main() {
  runApp(const CampingRentalApp());
}

class CampingRentalApp extends StatelessWidget {
  const CampingRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camping Rental',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/quiz',
      routes: {
        '/': (context) => const HomeScreen(),
        '/item-detail': (context) => const ItemDetailScreen(),
        '/reviews': (context) => const ReviewsScreen(),
        '/chat': (context) => const ChatScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/cart': (context) => const CartScreen(),
        '/promotions': (context) => const PromotionsScreen(),
        '/transactions': (context) => const TransactionsScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/returns': (context) => const ReturnsScreen(), // Add the new route
      },
    );
  }
}

