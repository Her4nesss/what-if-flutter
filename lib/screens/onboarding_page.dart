import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class OnboardingSlide {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingSlide({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

const List<OnboardingSlide> _slides = [
  OnboardingSlide(
    imagePath: 'assets/images/kiro_wave.png',
    title: 'Hai, aku Kiro!',
    subtitle: 'Aku bakal nemenin kamu menjawab pertanyaan-pertanyaan "What If?"',
  ),
  OnboardingSlide(
    imagePath: 'assets/images/kiro_thinking.png',
    title: 'Satu pertanyaan,\nbanyak kemungkinan',
    subtitle:
        'Kita bakal lihat apa yang mungkin terjadi dari berbagai sisi mulai dari manusia, masyarakat, ekonomi, teknologi, sampai hal-hal yang nggak kepikiran.',
  ),
  OnboardingSlide(
    imagePath: 'assets/images/kiro_excited.png',
    title: 'Yuk mulai jelajahi!',
    subtitle:
        'Pilih pertanyaan yang menarik buat kamu, atau tulis pertanyaan "What If?" versimu sendiri.',
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentPage = 0;

  void _goToWelcome() {
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  void _onNextPressed() {
    if (_currentPage == _slides.length - 1) {
      _goToWelcome();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _slides.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 4),
                child: TextButton(
                  onPressed: _goToWelcome,
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
            ),

            // Slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          slide.imagePath,
                          height: 260,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 260,
                            width: 260,
                            decoration: BoxDecoration(
                              color: AppColors.softBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.auto_awesome,
                                size: 60, color: AppColors.primary),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sora(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dot indicator + tombol
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slides.length, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      child: Text(isLastPage ? 'Get Started' : 'Next'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}