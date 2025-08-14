import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/providers/text_size_provider.dart';
import 'package:dlgc_hymnal/models/hymn_model.dart';
import 'package:dlgc_hymnal/features/hymn_details/hymn_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnListItem extends StatelessWidget {
  final HymnModel hymn;
  final VoidCallback onFavoriteTap;

  const HymnListItem({
    super.key,
    required this.hymn,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TextSizeProvider>(
      builder: (context, textSizeProvider, child) {
        return GestureDetector(
          onTap: () {
            DemoData.markAsRecentlyViewed(hymn.number);
            
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
              color: Colors.white,
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
                    hymn.number.toString(),
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
                        hymn.title,
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
                          if (hymn.category.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                hymn.category,
                                style: TextStyle(
                                  fontSize: textSizeProvider.smallText,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          if (hymn.tune.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Tune: ${hymn.tune}',
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
                        children: hymn.tags.map((tag) => _buildTag(tag, textSizeProvider)).toList(),
                      )
                    ],
                  ),
                ),
                IconButton( 
                  icon: Icon(
                    hymn.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: hymn.isFavorite ? Colors.red : Colors.grey,
                    size: 24, 
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSizeProvider.smallText,
          color: AppColors.primary,
        ),
      ),
    );
  }
}