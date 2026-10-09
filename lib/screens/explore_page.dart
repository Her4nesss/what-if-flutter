import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';
import '../widgets/question_row.dart';
import '../widgets/topic_tile.dart';
import 'categories_page.dart';
import 'question_detail_page.dart';
import 'question_list_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openQuestion(Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDetailPage(question: question),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = availableCategories;
    final isSearching = _searchQuery.isNotEmpty;
    final searchResults = isSearching
        ? questionsData.where((q) => q.matchesKeyword(_searchQuery)).toList()
        : <Question>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: AppColors.primary, size: 22),
                      const SizedBox(width: 6),
                      Text(
                        'What If?',
                        style: GoogleFonts.sora(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Belum ada notifikasi baru')),
                      );
                    },
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),

              // Sapaan + Kiro
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey, curious mind.',
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What do you want to explore today?',
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/kiro_mascot.png',
                    width: 80,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(width: 80),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Ask something impossible...',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onChanged: (value) {
                          setState(() => _searchQuery = value.trim());
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white, size: 18),
                        onPressed: () {
                          if (isSearching && searchResults.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Belum ada di database, coba kata kunci lain'),
                              ),
                            );
                          } else if (searchResults.length == 1) {
                            _openQuestion(searchResults.first);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              if (isSearching) ...[
                // Hasil pencarian
                const SizedBox(height: 16),
                Text(
                  searchResults.isEmpty
                      ? 'Nggak ketemu, coba kata kunci lain'
                      : '${searchResults.length} hasil',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                ...searchResults.map((q) => QuestionRow(
                      question: q,
                      onTap: () => _openQuestion(q),
                    )),
              ] else ...[
                // Explore by Topic
                const SizedBox(height: 20),
                _SectionHeader(
                  title: 'Explore by Topic',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoriesPage()),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 92,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 120,
                          child: TopicTile(
                            category: category,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionListPage(category: category),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Featured Questions
                const SizedBox(height: 20),
                _SectionHeader(
                  title: 'Featured Questions',
                  onSeeAll: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuestionListPage()),
                    );
                  },
                ),
                const SizedBox(height: 4),
                ...featuredQuestions.map((q) => QuestionRow(
                      question: q,
                      onTap: () => _openQuestion(q),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.sora(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        InkWell(
          onTap: onSeeAll,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: Text(
              'See all',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}