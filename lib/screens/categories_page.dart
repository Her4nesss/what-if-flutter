import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_shell.dart';
import '../widgets/content_frame.dart';
import '../widgets/topic_tile.dart';
import '../widgets/wide_topic_card.dart';
import 'question_list_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _open(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionListPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = AuthShell.isWide(context);
    final categories = availableCategories;

    return ContentFrame(
      wideMaxWidth: 1200,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(wide ? 32 : 20, 8, wide ? 32 : 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 20),
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore by Category',
                  style: GoogleFonts.sora(
                    fontSize: wide ? 28 : 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pilih topik yang bikin kamu penasaran.',
                  style: TextStyle(fontSize: 13.5, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: wide
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 180,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return WideTopicCard(
                              category: category,
                              onTap: () => _open(context, category),
                            );
                          },
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.4,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return TopicTile(
                              category: category,
                              onTap: () => _open(context, category),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}