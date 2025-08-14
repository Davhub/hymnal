import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/widgets/widgets.dart';
import 'package:dlgc_hymnal/core/providers/text_size_provider.dart';
import 'package:dlgc_hymnal/features/features.dart';
import 'package:dlgc_hymnal/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HymnsScreen extends StatefulWidget {
  final String? filterCategory;
  final String? filterType;
  final String? filterTune;
  const HymnsScreen({super.key, this.filterCategory, this.filterType, this.filterTune, });

  @override
  State<HymnsScreen> createState() => _HymnsScreenState();
}

class _HymnsScreenState extends State<HymnsScreen> {
  int _sortIndex = 0; // 0 = By Number, 1 = By Title
  bool _isGridView = false;
  String _searchQuery = '';
  List<HymnModel> _displayedHymns = [];

  @override
  void initState() {
    super.initState();
    _updateDisplayedHymns();
  }

  void _updateDisplayedHymns() {
    List<HymnModel> hymns = List.from(DemoData.hymns);

    // Apply initial filters from navigation
    if (widget.filterCategory != null) {
      hymns = hymns.where((hymn) => hymn.category == widget.filterCategory).toList();
    }
    if (widget.filterType != null) {
      hymns = hymns.where((hymn) => hymn.type == widget.filterType).toList();
    }
    if (widget.filterTune != null) {
      hymns = hymns.where((hymn) => hymn.tune == widget.filterTune).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      hymns = hymns.where((hymn) =>
        hymn.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        hymn.verses.any((verse) => verse.toLowerCase().contains(_searchQuery.toLowerCase()))
      ).toList();
    }
    
    // Sort based on selected index
    if (_sortIndex == 0) {
      hymns.sort((a, b) => a.number.compareTo(b.number));
    } else {
      hymns.sort((a, b) => a.title.compareTo(b.title));
    }
    
    setState(() {
      _displayedHymns = hymns;
    });
  }

  String _getScreenTitle() {
    if (widget.filterCategory != null) {
      return "${widget.filterCategory} Hymns (${_displayedHymns.length})";
    }
    if (widget.filterType != null) {
      return "${widget.filterType} Hymns (${_displayedHymns.length})";
    }
    if (widget.filterTune != null) {
      return "${widget.filterTune} Tune (${_displayedHymns.length})";
    }
    return "All Hymns (${_displayedHymns.length})";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TextSizeProvider>(
      builder: (context, textSizeProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              _getScreenTitle(),
              style: TextStyle(
                fontSize: textSizeProvider.titleText,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.view_list,
                  color: !_isGridView ? Colors.white : Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    _isGridView = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.grid_view,
                  color: _isGridView ? Colors.white : Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    _isGridView = true;
                  });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              if (widget.filterCategory != null || widget.filterType != null || widget.filterTune != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: AppColors.primary.withOpacity(0.1),
                  child: Row(
                    children: [
                      Icon(Icons.filter_list, color: AppColors.primary, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Filtered by: ${widget.filterCategory ?? widget.filterType ?? widget.filterTune}',
                        style: TextStyle(
                          fontSize: textSizeProvider.mediumText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HymnsScreen()),
                          );
                        },
                        child: Text(
                          'Clear Filter',
                          style: TextStyle(
                            fontSize: textSizeProvider.mediumText,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              // Search
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  onChanged: (value) {
                    _searchQuery = value;
                    _updateDisplayedHymns();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: "Search hymns...",
                    hintStyle: TextStyle(
                      fontSize: textSizeProvider.mediumText,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Tabs: By Number / By Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    _buildSortButton("By Number", 0, textSizeProvider),
                    const SizedBox(width: 8),
                    _buildSortButton("By Title", 1, textSizeProvider),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              if (_displayedHymns.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No hymns found',
                          style: TextStyle(
                            fontSize: textSizeProvider.titleText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filter',
                          style: TextStyle(
                            fontSize: textSizeProvider.mediumText,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                // Hymn list or grid
                Expanded(
                  child: _isGridView ? _buildGridView(textSizeProvider) : _buildListView(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView() {
  return ListView.builder(
    itemCount: _displayedHymns.length,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    itemBuilder: (context, index) {
      final hymn = _displayedHymns[index];
      return HymnListItem(
        hymn: hymn, // Only pass the hymn object
        onFavoriteTap: () {
          setState(() {
            DemoData.toggleFavorite(hymn.number);
          });
        },
      );
    },
  );
}

  Widget _buildGridView(TextSizeProvider textSizeProvider) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _displayedHymns.length,
      itemBuilder: (context, index) {
        final hymn = _displayedHymns[index];
        return _buildGridItem(hymn, textSizeProvider);
      },
    );
  }

  Widget _buildGridItem(HymnModel hymn, TextSizeProvider textSizeProvider) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 14,
                    child: Text(
                      hymn.number.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSizeProvider.smallText,
                      ),
                    ),
                  ),
                  // Favorite Icon
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        DemoData.toggleFavorite(hymn.number);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        hymn.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: hymn.isFavorite ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hymn.title,
                      style: TextStyle(
                        fontSize: textSizeProvider.mediumText,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Category
                    if (hymn.category.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          hymn.category,
                          style: TextStyle(
                            fontSize: textSizeProvider.smallText,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    
                    // Tags
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: hymn.tags.take(2).map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: textSizeProvider.smallText,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ); 
  }

  Widget _buildSortButton(String text, int index, TextSizeProvider textSizeProvider) {
    final isActive = _sortIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _sortIndex = index;
          });
          _updateDisplayedHymns();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: textSizeProvider.mediumText,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}