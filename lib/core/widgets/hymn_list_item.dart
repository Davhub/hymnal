import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/providers/text_size_provider.dart';
import 'package:dlgc_hymnal/models/hymn_model.dart';
import 'package:dlgc_hymnal/features/features.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnListItem extends StatelessWidget {
  final int number;
  final String title;
  final List<String> tags;
  final String? category;
  final String? tune;
  final VoidCallback onFavoriteTap;

  const HymnListItem({
    super.key,
    required this.number,
    required this.title,
    required this.tags,
    this.category,
    this.tune,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TextSizeProvider>(
      builder: (context, textSizeProvider, child) {
        return GestureDetector(
          onTap: () {
            final hymn = DemoData.hymns.firstWhere((h) => h.number == number);
            DemoData.markAsRecentlyViewed(number);
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HymnDetailsScreen(hymn: hymn),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: textSizeProvider.mediumText,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: textSizeProvider.largeText,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Category and Tune row with responsive text
                      Row(
                        children: [
                          if (category != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                category!,
                                style: TextStyle(
                                  fontSize: textSizeProvider.smallText,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          if (tune != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Tune: $tune',
                                style: TextStyle(
                                  fontSize: textSizeProvider.smallText,
                                  color: Colors.green[700],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: tags.map((tag) => _buildTag(tag, textSizeProvider)).toList(),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: onFavoriteTap,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTag(String text, TextSizeProvider textSizeProvider) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          fontSize: textSizeProvider.smallText,
          color: AppColors.primary,
        ),
      ),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}