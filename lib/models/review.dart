class Review {
  final String username;
  final String avatarUrl;
  final double rating;
  final String comment;
  final String date;

  Review({
    required this.username,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

final List<Review> sampleReviews = [
  Review(
    username: 'Monica S.',
    avatarUrl: 'https://randomuser.me/api/portraits/women/35.jpg',
    rating: 5.0,
    comment: 'Excellent tent! It was easy to set up and kept us dry during an unexpected rainstorm. Definitely recommend it.',
    date: '2 days ago',
  ),
  Review(
    username: 'Alex T.',
    avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
    rating: 4.5,
    comment: 'Great quality for the price. The tent was spacious enough for 2 people plus gear. Setup took about 5 minutes.',
    date: '1 week ago',
  ),
  Review(
    username: 'Rahmat K.',
    avatarUrl: 'https://randomuser.me/api/portraits/men/60.jpg',
    rating: 5.0,
    comment: 'This tent saved our camping trip! Very sturdy in windy conditions and completely waterproof.',
    date: '2 weeks ago',
  ),
  Review(
    username: 'Linda P.',
    avatarUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
    rating: 4.0,
    comment: 'Good tent overall. The only issue I had was with one of the zippers being slightly sticky.',
    date: '3 weeks ago',
  ),
  Review(
    username: 'David W.',
    avatarUrl: 'https://randomuser.me/api/portraits/men/29.jpg',
    rating: 5.0,
    comment: 'Perfect for weekend trips! Light enough to carry on hikes but durable enough to withstand rough conditions.',
    date: '1 month ago',
  ),
];

