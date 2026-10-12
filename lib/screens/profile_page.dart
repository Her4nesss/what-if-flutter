import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/app_state.dart';
import '../data/questions_data.dart';
import '../models/question.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_shell.dart';
import 'question_detail_page.dart';

class ProfilePage extends StatefulWidget {
  // Dipanggil tombol "Mulai jelajah" saat belum ada riwayat
  final VoidCallback? onGoExplore;

  const ProfilePage({super.key, this.onGoExplore});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = 'Explorer';
  String _fullname = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _username = prefs.getString('username') ?? 'Explorer';
      _fullname = prefs.getString('fullname') ?? '';
    });
  }

  String get _displayName => _fullname.isNotEmpty ? _fullname : _username;

  Future<void> _pickAvatar() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    // Disimpan di avatarNotifier, jadi navbar atas ikut berubah
    avatarNotifier.value = await picked.readAsBytes();
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar akun?'),
        content: const Text('Kamu perlu login lagi buat masuk ke aplikasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    avatarNotifier.value = null;

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
  }

  Map<String, double> _topCategoryProgress() {
    final Map<String, int> totalPerCategory = {};
    final Map<String, int> exploredPerCategory = {};

    for (final q in questionsData) {
      totalPerCategory[q.category] = (totalPerCategory[q.category] ?? 0) + 1;
      if (q.isExplored) {
        exploredPerCategory[q.category] =
            (exploredPerCategory[q.category] ?? 0) + 1;
      }
    }

    final Map<String, double> result = {};
    totalPerCategory.forEach((category, total) {
      final explored = exploredPerCategory[category] ?? 0;
      if (explored > 0) result[category] = explored / total;
    });

    final sorted = result.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sorted.take(3));
  }

  void _openQuestion(Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDetailPage(question: question),
      ),
    ).then((_) {
      if (mounted) setState(() {}); // segarkan angka saat kembali
    });
  }

  @override
  Widget build(BuildContext context) {
    final exploredCount = questionsData.where((q) => q.isExplored).length;
    final savedList = savedQuestions;
    final recentList = recentlyExploredQuestions.take(5).toList();
    final topCategories = _topCategoryProgress();

    if (AuthShell.isWide(context)) {
      return _wide(exploredCount, savedList, recentList, topCategories);
    }
    return _mobile(exploredCount, savedList, recentList, topCategories);
  }

  // ===== HP / jendela sempit =====
  Widget _mobile(
    int exploredCount,
    List<Question> savedList,
    List<Question> recentList,
    Map<String, double> topCategories,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome,
                      color: AppColors.primary, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'What If?',
                    style: GoogleFonts.sora(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _avatar(34),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayName,
                          style: GoogleFonts.sora(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _badge(),
                        const SizedBox(height: 6),
                        _tagline(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _statsCard(exploredCount, savedList.length),
              if (topCategories.isNotEmpty) ...[
                const SizedBox(height: 24),
                _label('YOUR CURIOSITY'),
                const SizedBox(height: 4),
                Text(
                  'Most explored topics',
                  style: GoogleFonts.sora(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 14),
                ..._curiosityRows(topCategories),
              ],
              if (recentList.isNotEmpty) ...[
                const SizedBox(height: 20),
                _label('RECENTLY EXPLORED'),
                const SizedBox(height: 10),
                ..._historyTiles(recentList),
              ],
              if (savedList.isNotEmpty) ...[
                const SizedBox(height: 20),
                _label('SAVED QUESTIONS'),
                const SizedBox(height: 10),
                ..._historyTiles(savedList),
              ],
              const SizedBox(height: 28),
              _logoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Layar lebar: 2 kolom =====
  Widget _wide(
    int exploredCount,
    List<Question> savedList,
    List<Question> recentList,
    Map<String, double> topCategories,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 48),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: _identityCard(exploredCount, savedList.length),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionCard(
                          label: 'YOUR CURIOSITY',
                          title: 'Most explored topics',
                          child: topCategories.isEmpty
                              ? _emptyText(
                                  'Jelajahi beberapa pertanyaan, nanti topik favoritmu muncul di sini.')
                              : Column(children: _curiosityRows(topCategories)),
                        ),
                        _sectionCard(
                          label: 'RECENTLY EXPLORED',
                          child: recentList.isEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _emptyText('Belum ada yang dijelajahi.'),
                                    if (widget.onGoExplore != null) ...[
                                      const SizedBox(height: 12),
                                      OutlinedButton(
                                        onPressed: widget.onGoExplore,
                                        child: const Text('Mulai jelajah'),
                                      ),
                                    ],
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: _historyTiles(recentList),
                                ),
                        ),
                        _sectionCard(
                          label: 'SAVED QUESTIONS',
                          child: savedList.isEmpty
                              ? _emptyText(
                                  'Belum ada pertanyaan tersimpan. Ketuk ikon bookmark di halaman detail.')
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: _historyTiles(savedList),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===== Potongan yang dipakai kedua tampilan =====
  Widget _identityCard(int explored, int saved) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _avatar(46),
          const SizedBox(height: 14),
          Text(
            _displayName,
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          _badge(),
          const SizedBox(height: 8),
          _tagline(center: true),
          const SizedBox(height: 20),
          _statsCard(explored, saved),
          const SizedBox(height: 20),
          _logoutButton(),
        ],
      ),
    );
  }

  Widget _avatar(double radius) {
    final initial =
        _displayName.isNotEmpty ? _displayName[0].toUpperCase() : '?';
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: [
          ValueListenableBuilder<Uint8List?>(
            valueListenable: avatarNotifier,
            builder: (context, bytes, _) {
              return CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.softBlue,
                backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                child: bytes == null
                    ? Text(
                        initial,
                        style: TextStyle(
                          fontSize: radius * 0.8,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickAvatar,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.edit, size: 13, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge() {
    return const Text(
      'CURIOUS MIND',
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _tagline({bool center = false}) {
    return Text(
      "Let's see what could happen.",
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
    );
  }

  Widget _statsCard(int explored, int saved) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.science_outlined,
              value: '$explored',
              label: 'Explored Questions',
            ),
          ),
          Container(width: 1, height: 36, color: Colors.white),
          Expanded(
            child: _StatItem(
              icon: Icons.bookmark_outline,
              value: '$saved',
              label: 'Saved Questions',
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _sectionCard({
    required String label,
    String? title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          if (title != null) ...[
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.sora(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _emptyText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13.5, height: 1.5, color: Colors.grey.shade700),
    );
  }

  List<Widget> _curiosityRows(Map<String, double> topCategories) {
    return topCategories.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.softBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                categoryIcons[entry.key] ?? '❓',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: entry.value,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${(entry.value * 100).round()}%',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _historyTiles(List<Question> list) {
    return list
        .map((q) => _HistoryTile(question: q, onTap: () => _openQuestion(q)))
        .toList();
  }

  Widget _logoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _logout,
        icon: const Icon(Icons.logout, size: 18),
        label: const Text('Logout'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.5, color: Colors.grey.shade800),
        ),
      ],
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final Question question;
  final VoidCallback onTap;

  const _HistoryTile({required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                question.imagePath,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 44,
                  height: 44,
                  color: AppColors.softBlue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                question.title,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}