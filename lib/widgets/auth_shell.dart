import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AuthShell extends StatelessWidget {
  final Widget child;

  const AuthShell({super.key, required this.child});

  static const double breakpoint = 900;

  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= breakpoint;

  @override
  Widget build(BuildContext context) {
    // Layar sempit (HP): tampilkan halaman apa adanya
    if (!isWide(context)) return child;

    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final h = c.maxHeight < 720 ? 720.0 : c.maxHeight;
          final cardWidth = (w * 0.38).clamp(440.0, 620.0).toDouble();
          final sideMargin = (w * 0.04).clamp(24.0, 72.0).toDouble();
          final vMargin = (h * 0.06).clamp(24.0, 56.0).toDouble();
          final leftWidth = w - cardWidth - sideMargin;
          final headlineSize = (w * 0.036).clamp(36.0, 64.0).toDouble();

          return SingleChildScrollView(
            child: SizedBox(
              width: w,
              height: h,
              child: Stack(
                children: [
                  // latar navy dengan cahaya halus di kiri atas
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(-0.2, -0.9),
                          radius: 1.3,
                          colors: [const Color(0xFF1E3A8A), AppColors.deepNavy],
                        ),
                      ),
                    ),
                  ),
                  // planet redup di pojok kiri bawah
                  Positioned(
                    left: -160,
                    bottom: -200,
                    child: _Circle(480, AppColors.primary.withValues(alpha: 0.18)),
                  ),

                  // ===== area kiri: branding + Kiro =====
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: leftWidth,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(painter: _OrbitPainter()),
                        ),
                        Positioned(
                          left: sideMargin,
                          top: vMargin,
                          child: Row(
                            children: [
                              const Icon(Icons.auto_awesome,
                                  color: AppColors.scienceCyan, size: 26),
                              const SizedBox(width: 8),
                              Text(
                                'What If?',
                                style: GoogleFonts.sora(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: sideMargin,
                          right: sideMargin,
                          top: vMargin + 72,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: GoogleFonts.sora(
                                    fontSize: headlineSize,
                                    height: 1.12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  children: const [
                                    TextSpan(text: 'Apa yang terjadi\n'),
                                    TextSpan(
                                      text: 'kalau...?',
                                      style: TextStyle(color: AppColors.scienceCyan),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'Jelajahi skenario hipotetis dan lihat dampaknya dari berbagai sisi.',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: vMargin,
                          height: h * 0.52,
                          child: const _KiroStage(),
                        ),
                      ],
                    ),
                  ),

                  // ===== kartu putih di kanan =====
                  Positioned(
                    top: vMargin,
                    bottom: vMargin,
                    right: sideMargin,
                    width: cardWidth,
                    child: Material(
                      color: Colors.white,
                      elevation: 12,
                      shadowColor: Colors.black54,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAlias,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _KiroStage extends StatelessWidget {
  const _KiroStage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return Stack(
          children: [
            // pijakan bercahaya di bawah kaki Kiro
            Align(
              alignment: const Alignment(-0.1, 1),
              child: ClipOval(
                child: Container(
                  width: 380,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.65),
                        AppColors.primary.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ikon dekoratif
            const Align(alignment: Alignment(-0.75, -0.1), child: _Atom()),
            Align(
              alignment: const Alignment(0.6, -0.45),
              child: Icon(Icons.public,
                  size: 40,
                  color: AppColors.scienceCyan.withValues(alpha: 0.85)),
            ),
            Align(
              alignment: const Alignment(0.7, 0.35),
              child: Icon(Icons.hub_outlined,
                  size: 34,
                  color: AppColors.scienceCyan.withValues(alpha: 0.85)),
            ),
            Align(
              alignment: const Alignment(-0.8, 0.55),
              child: Icon(Icons.auto_awesome,
                  size: 20,
                  color: AppColors.scienceCyan.withValues(alpha: 0.85)),
            ),
            // Kiro berdiri
            Align(
              alignment: const Alignment(-0.1, 0.9),
              child: Image.asset(
                'assets/images/kiro_mascot.png',
                height: c.maxHeight * 0.95,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    SizedBox(height: c.maxHeight * 0.95),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Atom extends StatelessWidget {
  const _Atom();

  @override
  Widget build(BuildContext context) {
    Widget orbit(double angle) => Transform.rotate(
          angle: angle,
          child: Container(
            width: 64,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.scienceCyan, width: 1.6),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        );

    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          orbit(0),
          orbit(1.047),
          orbit(2.094),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.scienceCyan,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = AppColors.scienceCyan.withValues(alpha: 0.35);

    void ring(double wFactor, double hFactor, double angle) {
      canvas.save();
      canvas.translate(size.width * 0.45, size.height * 0.68);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: size.width * wFactor,
          height: size.height * hFactor,
        ),
        paint,
      );
      canvas.restore();
    }

    ring(0.95, 0.34, -0.2);
    ring(0.62, 0.22, 0.12);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;

  const _Circle(this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}