import 'package:flutter/material.dart';
import '../models/camping_item.dart';
import '../widgets/camping_item_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Mock data - in a real app this would come from a user's wishlist
  final List<CampingItem> _wishlistItems = [
    CampingItem(
      id: 1,
      name: 'Dome Tent (2-Person)',
      description: 'Compact, lightweight 2-person dome tent, perfect for weekend camping trips. Features waterproof construction and easy setup.',
      price: 15.0,
      imageUrl: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?q=80&w=1470&auto=format&fit=crop',
      rating: 4.8,
      reviewCount: 124,
      isFavorite: true,
      tags: ['Tent', 'Popular', 'Lightweight'],
    ),
    CampingItem(
      id: 7,
      name: 'Water Filter System',
      description: 'Portable water filter that removes 99.99% of bacteria and parasites. Filters up to 1,000 liters.',
      price: 9.0,
      imageUrl: 'https://images.unsplash.com/photo-1571126770237-507d2dbfc8fe?q=80&w=1374&auto=format&fit=crop',
      rating: 4.9,
      reviewCount: 134,
      isFavorite: true,
      tags: ['Water', 'Safety', 'Popular'],
    ),
    CampingItem(
      id: 8,
      name: 'Hammock with Mosquito Net',
      description: 'Lightweight camping hammock with integrated mosquito net. Includes tree straps and carabiners.',
      price: 10.0,
      imageUrl: 'https://images.unsplash.com/photo-1518607030128-f0cb0d6a2e81?q=80&w=1470&auto=format&fit=crop',
      rating: 4.7,
      reviewCount: 91,
      isFavorite: true,
      tags: ['Relaxation', 'Summer'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _wishlistItems.isNotEmpty
                ? () {
                    // Show confirmation dialog for clearing wishlist
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Clear Wishlist'),
                        content: const Text('Are you sure you want to remove all items from your wishlist?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _wishlistItems.clear();
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Wishlist cleared'),
                                ),
                              );
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
      body: _wishlistItems.isEmpty
          ? _buildEmptyState()
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _wishlistItems.length,
              itemBuilder: (context, index) {
                return CampingItemCard(
                  item: _wishlistItems[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/item-detail',
                      arguments: _wishlistItems[index],
                    );
                  },
                  onFavoriteToggle: () {
                    setState(() {
                      // Remove from wishlist
                      _wishlistItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Removed from wishlist'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
      bottomSheet: _wishlistItems.isEmpty
          ? null
          : Container(
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
              child: ElevatedButton(
                onPressed: () {
                  // Add all items to cart
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All items added to cart!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pushNamed(context, '/cart');
                },
                child: const Text('Add All to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Save items you like by tapping the heart icon',
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

