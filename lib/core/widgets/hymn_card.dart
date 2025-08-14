import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/models/hymn_model.dart';
import 'package:dlgc_hymnal/features/hymn_details/hymn_details_screen.dart';
import 'package:flutter/material.dart';

class HymnCard extends StatefulWidget {
  final HymnModel hymn;
  final VoidCallback? onFavoriteChanged;

  const HymnCard({
    super.key,
    required this.hymn,
    this.onFavoriteChanged,
  });

  @override
  State<HymnCard> createState() => _HymnCardState();
}

class _HymnCardState extends State<HymnCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      DemoData.toggleFavorite(widget.hymn.number);
    });
    
    // Animate the heart
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    
    // Call the callback if provided
    widget.onFavoriteChanged?.call();
    
    // Show feedback to user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.hymn.isFavorite 
              ? '${widget.hymn.title} added to favorites' 
              : '${widget.hymn.title} removed from favorites',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primary,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              DemoData.toggleFavorite(widget.hymn.number);
            });
            widget.onFavoriteChanged?.call();
          },
        ),
      ),
    );
  }

  void _navigateToHymn() {
    // Mark as recently viewed
    DemoData.markAsRecentlyViewed(widget.hymn.number);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HymnDetailsScreen(hymn: widget.hymn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToHymn,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Hymn Number Circle
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              radius: 24,
              child: Text(
                widget.hymn.number.toString(),
                style: AppTextStyle.hymnNumber.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Hymn Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hymn.title,
                    style: AppTextStyle.hymnTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Category badge
                  if (widget.hymn.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.hymn.category,
                        style: AppTextStyle.label.copyWith(
                          color: AppColors.primary,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  
                  // Tags
                  Wrap(
                    spacing: 4,
                    children: widget.hymn.tags.take(3).map((tag) => 
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: AppTextStyle.label.copyWith(fontSize: 10),
                        ),
                      ),
                    ).toList(),
                  ),
                ],
              ),
            ),
            
            // Favorite Button with Animation
            GestureDetector(
              onTap: _toggleFavorite,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        widget.hymn.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: widget.hymn.isFavorite ? AppColors.primary : Colors.grey,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}