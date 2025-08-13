import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class HymnCard extends StatelessWidget {
  final int index;
  final String title;
  final List<String> tags;

  const HymnCard({
    super.key,
    required this.index,
    required this.title,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text("$index", style: AppTextStyle.hymnNumber.copyWith(color: AppColors.primary),),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.hymnTitle.copyWith(fontSize: 16),),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: tags
                      .map((tag) => Chip(
                            label: Text(tag, style: AppTextStyle.label.copyWith(
                                color: AppColors.primary,
                              ),),
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            
                          ))
                      .toList(),
                )
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
