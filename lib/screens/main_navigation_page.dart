import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_shell.dart';
import '../widgets/content_frame.dart';
import 'about_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // 0 = Explore, 1 = Profile, 2 = About (About hanya ada di layar lebar)
  int _currentIndex = 0;

  void _go(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    if (AuthShell.isWide(context)) return _wide(context);
    return ContentFrame(child: _mobile(context));
  }

  // ===== HP / jendela sempit =====
  Widget _mobile(BuildContext context) {
    final mobileIndex = _currentIndex == 1 ? 1 : 0;

    return Scaffold(
      body: IndexedStack(
        index: mobileIndex,
        children: [
          const ExplorePage(),
          // Sengaja TIDAK const: supaya Profile dibangun ulang saat tab
          // berpindah dan data saved/explored selalu terbaru.
          ProfilePage(onGoExplore: () => _go(0)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mobileIndex,
        onTap: _go,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ===== Layar lebar: navbar atas =====
  Widget _wide(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _TopBar(
            currentIndex: _currentIndex,
            onExplore: () => _go(0),
            onAbout: () => _go(2),
            onProfile: () => _go(1),
            onBell: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Belum ada notifikasi baru')),
              );
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              sizing: StackFit.expand,
              children: [
                const ExplorePage(),
                // Tidak const (lihat catatan di _mobile)
                ProfilePage(onGoExplore: () => _go(0)),
                const AboutPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onExplore;
  final VoidCallback onAbout;
  final VoidCallback onProfile;
  final VoidCallback onBell;

  const _TopBar({
    required this.currentIndex,
    required this.onExplore,
    required this.onAbout,
    required this.onProfile,
    required this.onBell,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            color: AppColors.primary, size: 26),
                        const SizedBox(width: 8),
                        Text(
                          'What If?',
                          style: GoogleFonts.sora(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  _NavLink(
                    label: 'Explore',
                    selected: currentIndex == 0,
                    onTap: onExplore,
                  ),
                  _NavLink(
                    label: 'About',
                    selected: currentIndex == 2,
                    onTap: onAbout,
                  ),
                  const Spacer(),
                  Center(
                    child: IconButton(
                      onPressed: onBell,
                      icon: const Icon(Icons.notifications_none),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Center(
                    child: InkWell(
                      onTap: onProfile,
                      customBorder: const CircleBorder(),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: currentIndex == 1
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: ValueListenableBuilder<Uint8List?>(
                          valueListenable: avatarNotifier,
                          builder: (context, bytes, _) {
                            return CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.softBlue,
                              backgroundImage:
                                  bytes != null ? MemoryImage(bytes) : null,
                              child: bytes == null
                                  ? const Icon(Icons.person,
                                      size: 18, color: AppColors.primary)
                                  : null,
                            );
                          },
                        ),
                      ),
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

class _NavLink extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.primary : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.primary : AppColors.deepNavy,
          ),
        ),
      ),
    );
  }
}