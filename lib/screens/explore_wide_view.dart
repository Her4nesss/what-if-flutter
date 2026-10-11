import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions_data.dart';
import '../models/question.dart';
import '../theme/app_colors.dart';
import '../widgets/wide_topic_card.dart';
import 'categories_page.dart';
import 'question_detail_page.dart';
import 'question_list_page.dart';

const double _maxContentWidth = 1200;
const double _topicCardWidth = 272;
const double _topicCardGap = 16;

class ExploreWideView extends StatefulWidget {
  const ExploreWideView({super.key});

  @override
  State<ExploreWideView> createState() => _ExploreWideViewState();
}

class _ExploreWideViewState extends State<ExploreWideView> {
  final _searchController = TextEditingController();
  final _topicScroll = ScrollController();
  String _query = '';

  List<Question> get _results =>
      questionsData.where((q) => q.matchesKeyword(_query)).toList();

  @override
  void dispose() {
    _searchController.dispose();
    _topicScroll.dispose();
    super.dispose();
  }

  void _scrollTopics(double delta) {
    if (!_topicScroll.hasClients) return;
    final pos = _topicScroll.position;
    final target =
        (pos.pixels + delta).clamp(0.0, pos.maxScrollExtent).toDouble();
    _topicScroll.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _openQuestion(Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDetailPage(question: question),
      ),
    );
  }

  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionListPage(category: category),
      ),
    );
  }

  void _openAllCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CategoriesPage()),
    );
  }

  void _openAllQuestions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuestionListPage()),
    );
  }

  void _submitSearch() {
    if (_query.isEmpty) return;
    final results = _results;
    if (results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belum ada di database, coba kata kunci lain'),
        ),
      );
    } else if (results.length == 1) {
      _openQuestion(results.first);
    }
  }

  Widget _centered(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = _query.isNotEmpty;
    final results = isSearching ? _results : <Question>[];
    final topics = availableCategories;

    return Material(
      color: AppColors.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _hero(context),
            _centered(
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isSearching
                      ? _searchSection(results)
                      : _defaultSection(topics),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== HERO =====
  Widget _hero(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final contentWidth = width > _maxContentWidth ? _maxContentWidth : width;
    final headlineSize = (contentWidth * 0.045).clamp(34.0, 54.0).toDouble();

    return Container(
      width: double.infinity,
      color: AppColors.softBlue.withValues(alpha: 0.55),
      child: _centered(
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 44, 16, 52),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.sora(
                          fontSize: headlineSize,
                          height: 1.1,
                          fontWeight: FontWeight.w800,
                          color: AppColors.deepNavy,
                        ),
                        children: const [
                          TextSpan(text: 'Hey, curious '),
                          TextSpan(
                            text: 'mind.',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'What do you want to explore today?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _searchBar(),
                  ],
                ),
              ),
            ),
            Expanded(flex: 4, child: _kiro()),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(Icons.search, color: Colors.grey.shade600),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Ask something impossible...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
                onChanged: (value) => setState(() => _query = value.trim()),
                onSubmitted: (_) => _submitSearch(),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 20),
                onPressed: _submitSearch,
              ),
            ),
            const SizedBox(width: 2),
          ],
        ),
      ),
    );
  }

    Widget _kiro() {
    const double boxHeight = 340; // tinggi area Kiro (hero ikut menyesuaikan)
    const double imageHeight = 340; // ukuran gambar Kiro
    const double cropBottom = 1; // makin besar, Kiro makin naik
    const double leftGap = 10; // makin besar, Kiro makin ke kiri
    const double textRight = -30; // negatif = tulisan makin ke kanan
    const double textTop = 70; // makin besar, tulisan makin turun

    return SizedBox(
      height: boxHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.topCenter,
                minHeight: 0,
                maxHeight: imageHeight,
                maxWidth: double.infinity,
                child: Transform.translate(
                  offset: const Offset(-leftGap, -cropBottom),
                  child: Image.asset(
                    'assets/images/kiro_excited.png',
                    height: imageHeight,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(height: boxHeight),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: textRight,
            top: textTop,
            child: Transform.rotate(
              angle: -0.12,
              child: Text(
                'Big questions\nlead to\ngreater discoveries.',
                style: GoogleFonts.caveat(
                  fontSize: 22,
                  height: 1.1,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== BAGIAN BAWAH =====
  List<Widget> _defaultSection(List<String> topics) {
    final step = (_topicCardWidth + _topicCardGap) * 2;

    return [
      _sectionHeader(
        'Explore by Topic',
        _openAllCategories,
        extra: topics.length > 3
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ArrowButton(
                    icon: Icons.arrow_back,
                    onTap: () => _scrollTopics(-step),
                  ),
                  const SizedBox(width: 8),
                  _ArrowButton(
                    icon: Icons.arrow_forward,
                    onTap: () => _scrollTopics(step),
                  ),
                  const SizedBox(width: 12),
                ],
              )
            : null,
      ),
      const SizedBox(height: 14),
      SizedBox(
        height: 190,
        child: ListView.builder(
          controller: _topicScroll,
          scrollDirection: Axis.horizontal,
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final category = topics[index];
            return Padding(
              padding: const EdgeInsets.only(right: _topicCardGap),
              child: SizedBox(
                width: _topicCardWidth,
                child: WideTopicCard(
                  category: category,
                  onTap: () => _openCategory(category),
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 36),
      _sectionHeader('Featured Questions', _openAllQuestions),
      const SizedBox(height: 14),
      _questionGrid(featuredQuestions),
    ];
  }

  List<Widget> _searchSection(List<Question> results) {
    return [
      Text(
        results.isEmpty
            ? 'Nggak ketemu, coba kata kunci lain'
            : '${results.length} hasil',
        style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
      ),
      const SizedBox(height: 14),
      _questionGrid(results),
    ];
  }

  Widget _sectionHeader(String title, VoidCallback onSeeAll, {Widget? extra}) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.sora(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavy,
          ),
        ),
        const Spacer(),
        if (extra != null) extra,
        InkWell(
          onTap: onSeeAll,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _questionGrid(List<Question> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        mainAxisExtent: 88,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final question = items[index];
        return _WideQuestionCard(
          question: question,
          onTap: () => _openQuestion(question),
        );
      },
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: CircleBorder(side: BorderSide(color: Colors.grey.shade300)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 34,
          height: 34,
          child: Icon(icon, size: 18, color: AppColors.deepNavy),
        ),
      ),
    );
  }
}

class _WideQuestionCard extends StatelessWidget {
  final Question question;
  final VoidCallback onTap;

  const _WideQuestionCard({required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    question.imagePath,
                    width: 84,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 84,
                      height: 64,
                      color: AppColors.softBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepNavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        question.category,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward, size: 18, color: Colors.grey.shade600),
              ],
            ),
          ),
        ),
      ),
    );
  }
}