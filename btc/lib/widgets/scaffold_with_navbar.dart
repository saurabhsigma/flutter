import 'package:btc/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserDataProvider);
    final isAdmin = userAsync.value?.isAdmin ?? false;

    // Filter destinations based on role. 
    // WARNING: Removing a destination from the list breaks the index mapping if `goBranch` relies on absolute index.
    // StatefulNavigationShell branches are fixed. If we want to hide one, we must ensure indices match.
    // However, GoRouter's StatefulShellRoute defines 3 branches (Home, Dashboard, Admin).
    // If we simply hide the button, index 2 (Admin) becomes inaccessible via UI, which is fine.
    
    final destinations = [
      const NavigationDestination(
         icon: Icon(Icons.home_outlined),
         selectedIcon: Icon(Icons.home, color: AppColors.primaryViolet),
         label: 'Home',
      ),
      const NavigationDestination(
         icon: Icon(Icons.dashboard_outlined),
         selectedIcon: Icon(Icons.dashboard, color: AppColors.primaryViolet),
         label: 'Dashboard',
      ),
      if (isAdmin) 
        const NavigationDestination(
           icon: Icon(Icons.admin_panel_settings_outlined),
           selectedIcon: Icon(Icons.admin_panel_settings, color: AppColors.primaryViolet),
           label: 'Admin',
        ),
    ];

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          // If we hide the Admin tab, the UI index (0, 1) matches branches (0, 1).
          // But if we are admin, indices (0, 1, 2) match.
          // Since we append Admin at the end, hiding it just means index 2 is never clicked.
          // BUT: if we are NOT admin, 'destinations' has length 2. 'navigationShell.currentIndex' should only be 0 or 1.
          _goBranch(index);
        },
        indicatorColor: AppColors.primaryViolet.withOpacity(0.2),
        destinations: destinations,
      ),
    );
  }
}
