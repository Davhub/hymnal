import 'package:dlgc_hymnal/core/components/components.dart';
import 'package:flutter/material.dart';
import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/features/features.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = [
    'Worship',
    'Praise',
    'Peace',
    'Faithfulness',
    'Devotion',
    'Prayer',
  ];

  final List<String> types = [
    'Grace',
    'Trinity',
    'Comfort',
    'Guidance',
    'Friendship',
    'Faith',
  ];

  final List<String> tunes = [
    'C.M.S',
    'M.F',
    'M.P',
    'G.H.C',
    'F.F.H',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToFilteredHymns({
    String? category,
    String? type,
    String? tune,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HymnsScreen(
          filterCategory: category,
          filterType: type,
          filterTune: tune,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories & Filters', style: AppTextStyle.h2.copyWith(color: AppColors.white),),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'Categories'),
            Tab(text: 'Types'),
            Tab(text: 'Tune'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FilterTabContent(
            items: categories,
            selectedItems: const <String>{}, // No persistent selection needed
            onItemSelected: (category) {
              _navigateToFilteredHymns(category: category);
            },
          ),
          FilterTabContent(
            items: types,
            selectedItems: const <String>{}, // No persistent selection needed
            onItemSelected: (type) {
              _navigateToFilteredHymns(type: type);
            },
          ),
          FilterTabContent(
            items: tunes,
            selectedItems: const <String>{}, // No persistent selection needed
            onItemSelected: (tune) {
              _navigateToFilteredHymns(tune: tune);
            },
          ),
        ],
      ),
    );
  }
}