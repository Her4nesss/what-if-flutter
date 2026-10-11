import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/onboarding_page.dart';
import 'theme/app_colors.dart';
import 'screens/main_navigation_page.dart';
import 'widgets/auth_shell.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseText = GoogleFonts.interTextTheme();
    final boldText = baseText.copyWith(
      bodyLarge: baseText.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      bodyMedium: baseText.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      bodySmall: baseText.bodySmall?.copyWith(fontWeight: FontWeight.w500),
    );
    return MaterialApp(
      title: 'What If?',
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
      

        textTheme: boldText,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),

      // Sekarang aplikasi pertama kali membuka Onboarding
      initialRoute: '/onboarding',

      routes: {
        '/onboarding': (context) => const AuthShell(child: OnboardingPage()),
        '/welcome': (context) => const AuthShell(child: WelcomePage()),
        '/login': (context) => const AuthShell(child: LoginPage()),
        '/signup': (context) => const AuthShell(child: SignupPage()),
        '/home': (context) => const MainNavigationPage(),
      },
    );
  }
}
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}