import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey.shade600,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: [
        _buildNavItem(Icons.home_outlined, "Home", 0),
        _buildNavItem(Icons.menu_book_outlined, "Hymns", 1),
        _buildNavItem(Icons.favorite_border, "Favorites", 2),
        _buildNavItem(Icons.filter_list_outlined, "Categories", 3),
        _buildNavItem(Icons.settings_outlined, "Settings", 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: currentIndex == index
              ? AppColors.primary.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: currentIndex == index
              ? AppColors.primary
              : Colors.grey.shade600,
        ),
      ),
      label: label,
    );
  }
}
