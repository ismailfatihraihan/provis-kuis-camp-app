class CampingItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final List<String> tags;

  CampingItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    this.reviewCount = 0,
    this.isFavorite = false,
    this.tags = const [],
  });
}

final List<CampingItem> featuredItems = [
  CampingItem(
    id: 1,
    name: 'Dome Tent (2-Person)',
    description: 'Compact, lightweight 2-person dome tent, perfect for weekend camping trips. Features waterproof construction and easy setup.',
    price: 15.0,
    imageUrl: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?q=80&w=1470&auto=format&fit=crop',
    rating: 4.8,
    reviewCount: 124,
    tags: ['Tent', 'Popular', 'Lightweight'],
  ),
  CampingItem(
    id: 2,
    name: 'Sleeping Bag (-10°C)',
    description: 'Warm and comfortable sleeping bag, rated for temperatures down to -10°C. Includes compression sack for easy transport.',
    price: 8.0,
    imageUrl: 'https://images.unsplash.com/photo-1520763185298-1b434c919102?q=80&w=1632&auto=format&fit=crop',
    rating: 4.6,
    reviewCount: 89,
    tags: ['Sleeping', 'Winter'],
  ),
  CampingItem(
    id: 3,
    name: 'Trekking Backpack 60L',
    description: 'Spacious 60L backpack with adjustable straps and multiple compartments. Ideal for multi-day hiking trips.',
    price: 12.0,
    imageUrl: 'https://images.unsplash.com/photo-1547949003-9792a18a2601?q=80&w=1470&auto=format&fit=crop',
    rating: 4.7,
    reviewCount: 105,
    tags: ['Backpack', 'Popular'],
  ),
  CampingItem(
    id: 4,
    name: 'Portable Gas Stove',
    description: 'Compact and efficient gas stove for outdoor cooking. Compatible with standard butane canisters.',
    price: 7.0,
    imageUrl: 'https://images.unsplash.com/photo-1602097944182-c43423a8056d?q=80&w=1470&auto=format&fit=crop',
    rating: 4.5,
    reviewCount: 76,
    tags: ['Cooking', 'Essentials'],
  ),
];

final List<CampingItem> popularItems = [
  CampingItem(
    id: 5,
    name: 'Headlamp (300 lumens)',
    description: 'Bright LED headlamp with adjustable strap and multiple light modes. Includes rechargeable battery.',
    price: 5.0,
    imageUrl: 'https://images.unsplash.com/photo-1553808373-99b457d6c9f0?q=80&w=1470&auto=format&fit=crop',
    rating: 4.4,
    reviewCount: 62,
    tags: ['Lighting', 'Night'],
  ),
  CampingItem(
    id: 6,
    name: 'Camping Chair',
    description: 'Foldable camping chair with cup holder and storage pocket. Supports up to 120kg.',
    price: 6.0,
    imageUrl: 'https://images.unsplash.com/photo-1534595038511-9f219fe0c979?q=80&w=1470&auto=format&fit=crop',
    rating: 4.3,
    reviewCount: 58,
    tags: ['Furniture', 'Comfort'],
  ),
  CampingItem(
    id: 7,
    name: 'Water Filter System',
    description: 'Portable water filter that removes 99.99% of bacteria and parasites. Filters up to 1,000 liters.',
    price: 9.0,
    imageUrl: 'https://images.unsplash.com/photo-1571126770237-507d2dbfc8fe?q=80&w=1374&auto=format&fit=crop',
    rating: 4.9,
    reviewCount: 134,
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
    tags: ['Relaxation', 'Summer'],
  ),
];

final List<CampingItem> newestItems = [
  CampingItem(
    id: 9,
    name: 'Inflatable Sleeping Pad',
    description: 'Comfortable inflatable sleeping pad with built-in pump. Provides excellent insulation from the ground.',
    price: 7.5,
    imageUrl: 'https://images.unsplash.com/photo-1577236375867-97db2d7c4d22?q=80&w=1374&auto=format&fit=crop',
    rating: 4.6,
    reviewCount: 45,
    tags: ['Sleeping', 'Comfort', 'New'],
  ),
  CampingItem(
    id: 10,
    name: 'Camping Cookware Set',
    description: 'Complete cookware set including pots, pans, and utensils. Made from lightweight anodized aluminum.',
    price: 12.0,
    imageUrl: 'https://images.unsplash.com/photo-1523686984263-216910a72dad?q=80&w=1374&auto=format&fit=crop',
    rating: 4.8,
    reviewCount: 37,
    tags: ['Cooking', 'New'],
  ),
];

final List<Map<String, dynamic>> promotions = [
  {
    'title': 'Weekend Package',
    'description': 'Complete set for a 2-day adventure',
    'items': [
      'Dome Tent (2-Person)',
      'Sleeping Bag (0°C)',
      'Inflatable Sleeping Pad',
      'Headlamp'
    ],
    'regularPrice': 38.0,
    'salePrice': 30.0,
    'imageUrl': 'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?q=80&w=1470&auto=format&fit=crop',
    'savePercentage': 21,
  },
  {
    'title': 'Family Camping Set',
    'description': 'Everything you need for family camping',
    'items': [
      'Family Tent (4-Person)',
      '4x Sleeping Bags',
      '4x Sleeping Pads',
      'Camping Stove',
      'Cookware Set'
    ],
    'regularPrice': 85.0,
    'salePrice': 65.0,
    'imageUrl': 'https://images.unsplash.com/photo-1563299796-17596ed6b017?q=80&w=1470&auto=format&fit=crop',
    'savePercentage': 24,
  },
];

