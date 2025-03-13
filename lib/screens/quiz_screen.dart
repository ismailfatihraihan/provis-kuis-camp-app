import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Set<String> visitedPages = {}; // Menyimpan halaman yang sudah dikunjungi

  void _navigateToPage(BuildContext context, String route) {
    setState(() {
      visitedPages.add(route); // Tandai halaman sebagai dikunjungi
    });
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz 1: UI'),
        centerTitle: true,
        backgroundColor: const Color(0xFF132A13), // Deep Forest Green
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                    color: Color(0xFF132A13), // Deep Green
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _buildNavigationButton(context, 'Halaman Depan', '/'),
              _buildNavigationButton(context, 'Rincian Item', '/item-detail'),
              _buildNavigationButton(context, 'Chat', '/chat'),
              _buildNavigationButton(context, 'Wishlist', '/wishlist'),
              _buildNavigationButton(context, 'Keranjang & Checkout', '/cart'),
              _buildNavigationButton(context, 'Pembelian Paket', '/promotions'),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFA68A64), // Muted Gold for contrast
                ),
              ),

              const Center(
                child: Text(
                  'Transaksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF132A13), // Deep Green
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _buildNavigationButton(context, 'Monitor Pesanan', '/transactions'),
              _buildNavigationButton(context, 'Pengembalian', '/returns'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String label, String route) {
    bool isVisited = visitedPages.contains(route);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton(
        onPressed: () => _navigateToPage(context, route),
        style: ElevatedButton.styleFrom(
          backgroundColor: isVisited ? const Color(0xFF4F7942) : const Color(0xFF132A13), // Warna pudar jika sudah dikunjungi
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 3,
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
