import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';
import 'question_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String? _selectedCategory;
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
    final categories = categoryIcons.keys.toList();

    // Kalau ada teks pencarian, cari berdasarkan judul
    final searchResults = _searchQuery.isEmpty
    ? <Question>[]
    : questionsData.where((q) => q.matchesKeyword(_searchQuery)).toList();

    final displayedQuestions = _selectedCategory == null
        ? questionsData
        : questionsData.where((q) => q.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
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
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Belum ada notifikasi baru')),
                      );
                    },
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Kiro + sapaan
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey, curious mind.',
                          style: GoogleFonts.sora(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What do you want to explore today?',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/kiro_mascot.png',
                    width: 90,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(width: 90),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search / Ask box
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
                          if (searchResults.isEmpty && _searchQuery.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Belum ada di database, coba pertanyaan pilihan di bawah'),
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

              // Hasil pencarian (kalau ada teks diketik)
              if (_searchQuery.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  searchResults.isEmpty
                      ? 'Nggak ketemu, coba kata kunci lain'
                      : 'Hasil pencarian',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 8),
                ...searchResults.asMap().entries.map((entry) => _QuestionCard(
                      question: entry.value,
                      index: entry.key + 1,
                      onTap: () => _openQuestion(entry.value),
                    )),
              ] else ...[
                const SizedBox(height: 24),
                Text(
                  'Explore Today',
                  style: GoogleFonts.sora(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedQuestions.length,
                  itemBuilder: (context, index) {
                    final question = displayedQuestions[index];
                    return _QuestionCard(
                      question: question,
                      index: index + 1,
                      onTap: () => _openQuestion(question),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  'Explore by Topic',
                  style: GoogleFonts.sora(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                  children: categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = isSelected ? null : category;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.softBlue,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(categoryIcons[category] ?? '❓',
                                style: const TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade700,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Question question;
  final int index;
  final VoidCallback onTap;

  const _QuestionCard({
    required this.question,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                index.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    question.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                question.imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: AppColors.softBlue,
                  child: const Icon(Icons.image_not_supported,
                      size: 18, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}