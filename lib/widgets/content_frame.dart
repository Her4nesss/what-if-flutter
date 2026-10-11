import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'auth_shell.dart';

class ContentFrame extends StatelessWidget {
  final Widget child;
  final double wideMaxWidth;

  const ContentFrame({
    super.key,
    required this.child,
    this.wideMaxWidth = 900,
  });

  @override
  Widget build(BuildContext context) {
    final wide = AuthShell.isWide(context);
    return ColoredBox(
      // layar lebar: kolom konten di tengah dengan warna latar yang sama
      // layar sempit: sama persis seperti sebelumnya
      color: wide ? AppColors.background : const Color(0xFFE2E8F0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: wide ? wideMaxWidth : 560),
          child: child,
        ),
      ),
    );
  }
}