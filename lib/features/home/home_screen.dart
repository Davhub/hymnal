import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/services/services.dart';
import 'package:dlgc_hymnal/core/widgets/widgets.dart';
import 'package:dlgc_hymnal/features/features.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({super.key, required this.initialIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(),
    HymnsScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _screens[_selectedIndex],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final showDailyHymn = SettingsService.showDailyHymn;
     
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Title
            Row(
              children: [
                Icon(Icons.music_note, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  "Divine Love Gospel Hymns",
                  style: AppTextStyle.h3,
                ),
              ],
            ),
            const SizedBox(height: 20),
    
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search hymns...',
                  hintStyle: AppTextStyle.bodyLarge,
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 24),
    
            // Today's Hymn
            if (showDailyHymn) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Hymn",
                      style: AppTextStyle.h3,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "How Firm A Foundation",
                          style: AppTextStyle.hymnTitle,
                        ),
                        Text(
                          "#8",
                          style: AppTextStyle.hymnNumber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "How firm a foundation, ye saints of the Lord,",
                      style: AppTextStyle.hymnVerse,
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: "Read Full Hymn",
                      onPressed: () {},
                      icon: Icons.book_outlined,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
    
            // Quick Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuickCard(
                  icon: Icons.menu_book,
                  label: "All Hymns",
                  count: "10 hymns",
                  onTap: () {},
                ),
                QuickCard(
                  icon: Icons.favorite_border,
                  label: "Favorites",
                  count: "0 hymns",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
    
            // Recently Viewed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently Viewed",
                  style: AppTextStyle.h3,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("See All", style: AppTextStyle.buttonMedium),
                ),
              ],
            ),
            const SizedBox(height: 8),
    
            // Recently Viewed List
            const HymnCard(
              index: 1,
              title: "Amazing Grace",
              tags: ["Worship", "Grace"],
            ),
            const HymnCard(
              index: 2,
              title: "How Great Thou Art",
              tags: ["Worship", "Praise"],
            ),
            const HymnCard(
              index: 3,
              title: "Holy, Holy, Holy",
              tags: ["Worship", "Trinity"],
            ),
          ],
        ),
      ),
    );
  }
}
