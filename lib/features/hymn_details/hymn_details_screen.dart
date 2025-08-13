import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/providers/text_size_provider.dart';
import 'package:dlgc_hymnal/models/hymn_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HymnDetailsScreen extends StatefulWidget {
  final HymnModel hymn;

  const HymnDetailsScreen({
    super.key,
    required this.hymn,
  });

  @override
  State<HymnDetailsScreen> createState() => _HymnDetailsScreenState();
}

class _HymnDetailsScreenState extends State<HymnDetailsScreen> {
  void _shareHymn() {
    final hymnText = '''
${widget.hymn.title} (Hymn #${widget.hymn.number})

${widget.hymn.header}

${widget.hymn.verses.asMap().entries.map((entry) => 'Verse ${entry.key + 1}:\n${entry.value}').join('\n\n')}

Shared via Divine Love Gospel Hymnal
''';
    
    Share.share(hymnText);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TextSizeProvider>(
      builder: (context, textSizeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  widget.hymn.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    DemoData.toggleFavorite(widget.hymn.number);
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: _shareHymn,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                _buildHymnHeader(textSizeProvider),
                Expanded(
                  child: _buildHymnContent(textSizeProvider),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHymnHeader(TextSizeProvider textSizeProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Text(
                  widget.hymn.number.toString(),
                  style: TextStyle(
                    fontSize: textSizeProvider.mediumText,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.hymn.title,
                  style: TextStyle(
                    fontSize: textSizeProvider.headingText,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Category and Tune row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.category_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.hymn.category,
                      style: TextStyle(
                        fontSize: textSizeProvider.smallText,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.music_note,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Tune: ${widget.hymn.tune}',
                      style: TextStyle(
                        fontSize: textSizeProvider.smallText,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Header text with responsive size
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.hymn.header,
              style: TextStyle(
                fontSize: textSizeProvider.mediumText,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: widget.hymn.tags.map((tag) => _buildTag(tag, textSizeProvider)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHymnContent(TextSizeProvider textSizeProvider) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.hymn.verses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: textSizeProvider.smallText,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              Text(
                widget.hymn.verses[index],
                style: TextStyle(
                  fontSize: textSizeProvider.verseText, // Optimized for reading hymn verses
                  fontWeight: FontWeight.normal,
                  height: 1.6, // Good line spacing for readability
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
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
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}