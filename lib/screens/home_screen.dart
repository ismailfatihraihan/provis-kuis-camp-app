import 'package:flutter/material.dart';
import '../models/camping_item.dart';
import '../widgets/camping_item_card.dart';
import '../widgets/promotion_card.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampGear Rental'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to search page
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications page
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          // Banner section
          Container(
            height: 180,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1508873696983-2dfd5898f08b?q=80&w=1470&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Camping Made Easy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rent premium gear for your next adventure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/promotions');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text('Explore Packages'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Categories section
          SectionTitle(
            title: 'Categories',
            onSeeAll: () {
              // Navigate to all categories
            },
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildCategoryItem(context, 'Tents', Icons.home_outlined),
                _buildCategoryItem(context, 'Sleeping', Icons.nightlight_outlined),
                _buildCategoryItem(context, 'Cooking', Icons.restaurant_outlined),
                _buildCategoryItem(context, 'Backpacks', Icons.backpack_outlined),
                _buildCategoryItem(context, 'Lighting', Icons.flashlight_on_outlined),
                _buildCategoryItem(context, 'Tools', Icons.handyman_outlined),
              ],
            ),
          ),

          // Featured items
          SectionTitle(
            title: 'Featured Items',
            onSeeAll: () {
              // Navigate to all featured items
            },
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: featuredItems.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: CampingItemCard(
                    item: featuredItems[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        '/item-detail',
                        arguments: featuredItems[index],
                      );
                    },
                    onFavoriteToggle: () {
                      // Toggle favorite status
                    },
                  ),
                );
              },
            ),
          ),

          // Promotions
          SectionTitle(
            title: 'Package Deals',
            onSeeAll: () {
              Navigator.pushNamed(context, '/promotions');
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: 1, // Show just the first promotion on homepage
            itemBuilder: (context, index) {
              return PromotionCard(
                promotion: promotions[index],
                onTap: () {
                  Navigator.pushNamed(context, '/promotions');
                },
              );
            },
          ),

          // Popular items
          SectionTitle(
            title: 'Popular Items',
            onSeeAll: () {
              // Navigate to all popular items
            },
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: popularItems.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: CampingItemCard(
                    item: popularItems[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        '/item-detail',
                        arguments: popularItems[index],
                      );
                    },
                    onFavoriteToggle: () {
                      // Toggle favorite status
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          // Handle navigation
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              Navigator.pushNamed(context, '/wishlist');
              break;
            case 2:
              Navigator.pushNamed(context, '/cart');
              break;
            case 3:
              Navigator.pushNamed(context, '/transactions');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, IconData icon) {
    return Container(
      width: 80,
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

