import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz 1: UI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'No kelompok praktikum: XY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              _buildNavigationButton(
                context,
                'Halaman Depan',
                () => Navigator.pushNamed(context, '/'),
              ),
              
              _buildNavigationButton(
                context,
                'Rincian Item',
                () => Navigator.pushNamed(context, '/item-detail'),
              ),
              
              _buildNavigationButton(
                context,
                'Chat',
                () => Navigator.pushNamed(context, '/chat'),
              ),
              
              _buildNavigationButton(
                context,
                'wishlist',
                () => Navigator.pushNamed(context, '/wishlist'),
              ),
              
              _buildNavigationButton(
                context,
                'Keranjang & Checkout',
                () => Navigator.pushNamed(context, '/cart'),
              ),
              
              _buildNavigationButton(
                context,
                'Pembelian Paket',
                () => Navigator.pushNamed(context, '/promotions'),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                ),
              ),
              
              const Center(
                child: Text(
                  'Transaksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              _buildNavigationButton(
                context,
                'Monitor Pesanan',
                () => Navigator.pushNamed(context, '/transactions'),
              ),
              
              _buildNavigationButton(
                context,
                'Pengembalian',
                () {
                  // This would navigate to a returns page if it existed
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Returns page not implemented yet'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavigationButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7D32), // Green color as requested
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

