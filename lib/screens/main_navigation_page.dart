import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_shell.dart';
import '../widgets/content_frame.dart';
import 'categories_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (AuthShell.isWide(context)) return _wide(context);
    return ContentFrame(child: _mobile(context));
  }

  // ===== HP / jendela sempit: sama seperti sebelumnya =====
  Widget _mobile(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ExplorePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
            onExplore: () => setState(() => _currentIndex = 0),
            onProfile: () => setState(() => _currentIndex = 1),
            onTopics: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesPage(),
                ),
              );
            },
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
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: const ProfilePage(),
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

class _TopBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onExplore;
  final VoidCallback onProfile;
  final VoidCallback onTopics;
  final VoidCallback onBell;

  const _TopBar({
    required this.currentIndex,
    required this.onExplore,
    required this.onProfile,
    required this.onTopics,
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
                      onTap: onExplore),
                  _NavLink(label: 'Topics', selected: false, onTap: onTopics),
                  _NavLink(
                      label: 'Profile',
                      selected: currentIndex == 1,
                      onTap: onProfile),
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
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.softBlue,
                        child: Icon(Icons.person,
                            size: 20, color: AppColors.primary),
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