import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';

class TopicTile extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const TopicTile({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              categoryImagePath(category),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: AppColors.deepNavy),
            ),
            // lapisan gelap tipis supaya teks putih tetap terbaca
            Container(color: Colors.black.withValues(alpha: 0.4)),
            Positioned(
              left: 10,
              right: 10,
              bottom: 8,
              child: Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}