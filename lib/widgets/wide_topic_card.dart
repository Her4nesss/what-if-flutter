import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';

const Map<String, IconData> topicIconData = {
  'Earth': Icons.public,
  'Human': Icons.person_outline,
  'Space': Icons.rocket_launch_outlined,
  'Technology': Icons.memory,
  'Mind': Icons.psychology_outlined,
};

const Map<String, String> topicSubtitles = {
  'Earth': 'Our planet, our home.',
  'Human': 'People, life, and society.',
  'Space': 'Beyond our world.',
  'Technology': 'Tools that shape tomorrow.',
  'Mind': 'Thoughts, consciousness, and more.',
};

class WideTopicCard extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const WideTopicCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final count = questionsData.where((q) => q.category == category).length;
    final subtitle = topicSubtitles[category] ?? '$count pertanyaan';

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            categoryImagePath(category),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: AppColors.deepNavy),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x14000000), Color(0xD90B1530)],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 14,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  topicIconData[category] ?? Icons.explore_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.sora(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }
}