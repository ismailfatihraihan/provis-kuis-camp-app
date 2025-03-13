import 'package:flutter/material.dart';
import '../models/camping_item.dart';
import '../models/review.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the item from the arguments
    final item = ModalRoute.of(context)!.settings.arguments as CampingItem? ?? 
      featuredItems[0]; // Fallback to first item if no arguments
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews & Ratings'),
      ),
      body: Column(
        children: [
          // Review summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          item.rating.toString(),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < item.rating.floor()
                                  ? Icons.star
                                  : index < item.rating 
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            );
                          }),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.reviewCount} reviews',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        children: [
                          _buildRatingBar(context, 5, 0.75),
                          _buildRatingBar(context, 4, 0.15),
                          _buildRatingBar(context, 3, 0.07),
                          _buildRatingBar(context, 2, 0.02),
                          _buildRatingBar(context, 1, 0.01),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // Show dialog to write a review
                    showDialog(
                      context: context,
                      builder: (context) => _buildReviewDialog(context, item),
                    );
                  },
                  child: const Text('Write a Review'),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Filter options
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.white,
            child: Row(
              children: [
                const Text('Filter by: '),
                const SizedBox(width: 8),
                Chip(
                  label: const Text('All'),
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                const SizedBox(width: 8),
                const Chip(
                  label: Text('With Photos'),
                ),
                const SizedBox(width: 8),
                const Chip(
                  label: Text('5 ★'),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Reviews list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: sampleReviews.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final review = sampleReviews[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(review.avatarUrl),
                            radius: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  review.date,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < review.rating.floor()
                                    ? Icons.star
                                    : i < review.rating 
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(review.comment),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up_outlined, size: 16),
                            onPressed: () {},
                          ),
                          const Text('Helpful (12)'),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Report'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRatingBar(BuildContext context, int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.secondary,
            size: 12,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                color: Theme.of(context).colorScheme.secondary,
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviewDialog(BuildContext context, CampingItem item) {
    double rating = 5.0;
    
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Rating'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating.floor()
                          ? Icons.star
                          : index < rating 
                              ? Icons.star_half
                              : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Text('Your Review'),
              const SizedBox(height: 8),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Share your experience with this product...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review submitted successfully!'),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      }
    );
  }
}

