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
    imageUrl: 'https://i0.wp.com/letstraveluk.com/wp-content/uploads/2021/05/felix-m-dorn-hcti0k5E2Iw-unsplash-scaled.jpg?w=2400&ssl=1',
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
    imageUrl: 'https://th.bing.com/th/id/R.e3dcd6d7d2ad9e585ce80c0c53a895ab?rik=E4ZN%2b5kNZcNFOA&riu=http%3a%2f%2fweb.tradekorea.com%2fproduct%2f372%2f737372%2fPortable+gas+stove-1.jpg&ehk=9IWVdehxN6TmzeCYCVS6JoLDwolSQLOEefa%2bn9bojnc%3d&risl=&pid=ImgRaw&r=0',
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
    imageUrl: 'https://i5.walmartimages.com/asr/e04f6148-b729-4e70-b2f9-ed37778ce4d3.dde323c753c167eef7909e60ef708c04.jpeg',
    rating: 4.4,
    reviewCount: 62,
    tags: ['Lighting', 'Night'],
  ),
  CampingItem(
    id: 6,
    name: 'Camping Chair',
    description: 'Foldable camping chair with cup holder and storage pocket. Supports up to 120kg.',
    price: 6.0,
    imageUrl: 'https://th.bing.com/th/id/OIP.zPja30hNFmzdgnTtvnxlpwAAAA?rs=1&pid=ImgDetMain',
    rating: 4.3,
    reviewCount: 58,
    tags: ['Furniture', 'Comfort'],
  ),
  CampingItem(
    id: 7,
    name: 'Water Filter System',
    description: 'Portable water filter that removes 99.99% of bacteria and parasites. Filters up to 1,000 liters.',
    price: 9.0,
    imageUrl: 'https://taskandpurpose.com/wp-content/uploads/2020/11/23/6-Sawyer-Products-mini-water-filtration-system.jpg?auto=webp&width=800&canvas=16:10,offset-x50',
    rating: 4.9,
    reviewCount: 134,
    tags: ['Water', 'Safety', 'Popular'],
  ),
  CampingItem(
    id: 8,
    name: 'Hammock with Mosquito Net',
    description: 'Lightweight camping hammock with integrated mosquito net. Includes tree straps and carabiners.',
    price: 10.0,
    imageUrl: 'https://th.bing.com/th/id/OIP.T80OTiHd_VqE7A2Tp1d7dgAAAA?rs=1&pid=ImgDetMain',
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
    imageUrl: 'https://i5.walmartimages.com/asr/445c0b8e-d011-4198-9bc5-4733c609c944.9fcf889acc864a2f726bc55fa5d1c922.jpeg',
    rating: 4.6,
    reviewCount: 45,
    tags: ['Sleeping', 'Comfort', 'New'],
  ),
  CampingItem(
    id: 10,
    name: 'Camping Cookware Set',
    description: 'Complete cookware set including pots, pans, and utensils. Made from lightweight anodized aluminum.',
    price: 12.0,
    imageUrl: 'https://i5.walmartimages.com/asr/571f3857-5ab3-4f19-b9f0-b0bf561d3d58.2103ab14dc9ac5719a4604ad6e6b8882.jpeg',
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

