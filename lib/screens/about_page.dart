import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 40, 32, 56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About What If?',
                              style: GoogleFonts.sora(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: AppColors.deepNavy,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'What If? adalah aplikasi untuk menjelajahi pertanyaan hipotetis. '
                              'Alih-alih satu paragraf jawaban, setiap pertanyaan diurai jadi '
                              'beberapa sisi dampak dan lini masa yang bisa kamu klik.',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Image.asset(
                        'assets/images/kiro_wave.png',
                        height: 170,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(height: 170),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Cara kerjanya',
                    style: GoogleFonts.sora(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _Step(
                    number: 1,
                    text: 'Pilih topik, atau ketik kata kunci di kolom pencarian.',
                  ),
                  const _Step(
                    number: 2,
                    text:
                        'Baca dampaknya dari enam sisi, lalu klik lini masa untuk melihat perkembangannya.',
                  ),
                  const _Step(
                    number: 3,
                    text:
                        'Simpan pertanyaan yang menarik, atau lanjut ke pertanyaan terkait lewat Take It Further.',
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.softBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Di Balik Setiap Jawaban',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepNavy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Setiap jawaban dirancang untuk membantumu mengeksplorasi berbagai kemungkinan secara '
                          'terstruktur. Hasilnya merupakan penjelasan yang dikurasi, bukan jawaban yang dihasilkan AI secara '
                          'langsung saat kamu menggunakannya.',
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.6,
                            color: Colors.grey.shade800,
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
}

class _Step extends StatelessWidget {
  final int number;
  final String text;

  const _Step({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.5,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}