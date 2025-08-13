import 'package:dlgc_hymnal/features/features.dart';
import 'package:dlgc_hymnal/models/hymn_model.dart';
import 'package:flutter/material.dart';
import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/widgets/widgets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    // Get actual favorites from demo data
    final List<HymnModel> favorites = DemoData.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Hymns (${favorites.length})', 
          style: AppTextStyle.h3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false, // Remove back button since this is a main screen
      ),
      body: favorites.isEmpty
          ? _buildEmptyState(context)
          : _buildFavoritesList(favorites),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'No Favorite Hymns Yet',
              style: AppTextStyle.h2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add hymns to your favorites for quick access to the ones you love most.',
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyLarge.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            // In the _buildEmptyState method, update the CustomButton onPressed:
CustomButton(
  text: "Browse Hymns",
  onPressed: () {
    // Navigate to HomeScreen with hymns tab selected (index 1)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(initialIndex: 1),
      ),
      (route) => false,
    );
  },
  icon: Icons.menu_book,
),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(List<HymnModel> favorites) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final hymn = favorites[index];
        return HymnListItem(
          number: hymn.number,
          title: hymn.title,
          tags: hymn.tags,
          category: hymn.category,
          tune: hymn.tune,
          onFavoriteTap: () {
            setState(() {
              DemoData.toggleFavorite(hymn.number);
            });
          },
        );
      },
    );
  }
}