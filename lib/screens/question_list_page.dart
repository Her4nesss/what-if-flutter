import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';
import '../widgets/content_frame.dart';
import '../widgets/question_row.dart';
import 'question_detail_page.dart';

class QuestionListPage extends StatelessWidget {
  final String? category; // null = tampilkan semua pertanyaan

  const QuestionListPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final items = category == null
        ? questionsData
        : questionsData.where((q) => q.category == category).toList();

    return ContentFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
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
                  category ?? 'All Questions',
                  style: GoogleFonts.sora(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${items.length} pertanyaan',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final question = items[index];
                      return QuestionRow(
                        question: question,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuestionDetailPage(question: question),
                            ),
                          );
                        },
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