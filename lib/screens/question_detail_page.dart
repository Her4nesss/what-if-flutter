import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question.dart';
import '../data/questions_data.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_shell.dart';
import '../widgets/content_frame.dart';

class QuestionDetailPage extends StatefulWidget {
  final Question question;

  const QuestionDetailPage({super.key, required this.question});

  @override
  State<QuestionDetailPage> createState() => _QuestionDetailPageState();
}

const Map<String, IconData> dimensionIcons = {
  'Biology': Icons.biotech,
  'Society': Icons.groups,
  'Economy': Icons.trending_up,
  'Technology': Icons.memory,
  'Environment': Icons.eco,
  'Unexpected Consequences': Icons.help_outline,
};

String _kiroReaction(String category) {
  const reactions = {
    'Earth': 'Wah, ini bisa ngubah cara Bumi bekerja secara total!',
    'Human': 'Coba bayangin kalau ini beneran kejadian ke tubuh kita...',
    'Space': 'Ruang angkasa emang penuh kejutan ya!',
    'Technology': 'Teknologi bisa berubah drastis kalau ini terjadi.',
    'Mind': 'Ini bikin aku mikir ulang soal cara otak kerja.',
  };
  return reactions[category] ?? 'Pertanyaan yang menarik banget!';
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  int _selectedStageIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.question.isExplored = true;
    recordExploration(widget.question.id);
  }

  // Foto banner: mengisi ruang yang diberikan induknya
  Widget _banner(Question q) {
    return Image.asset(
      q.imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.softBlue,
        child: const Icon(Icons.image_not_supported,
            size: 32, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      ContentFrame(child: _buildPage(context));

  Widget _buildPage(BuildContext context) {
    final question = widget.question;
    final wide = AuthShell.isWide(context);

    final relatedQuestions = question.relatedQuestionIds
        .map((id) {
          try {
            return getQuestionById(id);
          } catch (_) {
            return null;
          }
        })
        .whereType<Question>()
        .toList();

    final hasTimeline = question.timeline.isNotEmpty;
    final selectedStage =
        hasTimeline ? question.timeline[_selectedStageIndex] : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(wide ? 32 : 20, 12, wide ? 32 : 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: kembali, label, bookmark
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 20),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'WHAT IF?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        question.isSaved = !question.isSaved;
                      });
                    },
                    icon: Icon(
                      question.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Label kategori
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  question.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Foto banner
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: wide
                    ? AspectRatio(
                        aspectRatio: 16 / 7,
                        child: _banner(question),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: _banner(question),
                      ),
              ),
              const SizedBox(height: 14),

              // Judul dan jawaban singkat
              Text(
                question.title,
                style: GoogleFonts.sora(
                  fontSize: wide ? 28 : 24,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                question.shortAnswer,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 20),

              // Kiro + gelembung komentar
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/kiro_thinking.png',
                    height: 64,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(width: 64, height: 64),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.softBlue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        _kiroReaction(question.category),
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                          color: AppColors.deepNavy,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Timeline horizontal interaktif
              if (hasTimeline) ...[
                const SizedBox(height: 28),
                Text(
                  'What Happens Next?',
                  style: GoogleFonts.sora(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(question.timeline.length, (index) {
                    final isSelected = index == _selectedStageIndex;
                    final isLast = index == question.timeline.length - 1;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedStageIndex = index),
                        child: Column(
                          children: [
                            Text(
                              question.timeline[index].label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    color: index == 0
                                        ? Colors.transparent
                                        : (index <= _selectedStageIndex
                                            ? AppColors.primary
                                            : Colors.grey.shade300),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    color: isLast
                                        ? Colors.transparent
                                        : (index < _selectedStageIndex
                                            ? AppColors.primary
                                            : Colors.grey.shade300),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.deepNavy,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    selectedStage?.description ?? '',
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],

              // Dimensi dampak
              const SizedBox(height: 28),
              Text(
                'The Impact',
                style: GoogleFonts.sora(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              ...question.dimensions.entries.map(
                (entry) =>
                    _DimensionTile(label: entry.key, content: entry.value),
              ),

              // Take It Further
              if (relatedQuestions.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Take It Further',
                  style: GoogleFonts.sora(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                ...relatedQuestions.map(
                  (related) => _RelatedQuestionTile(
                    question: related,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionDetailPage(question: related),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DimensionTile extends StatelessWidget {
  final String label;
  final String content;

  const _DimensionTile({required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.softBlue,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              dimensionIcons[label] ?? Icons.help_outline,
              size: 17,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedQuestionTile extends StatelessWidget {
  final Question question;
  final VoidCallback onTap;

  const _RelatedQuestionTile({required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question.title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}