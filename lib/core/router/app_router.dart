import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/record/pages/record_list_page.dart';
import '../../features/statistics/pages/statistics_page.dart';
import '../../features/knowledge/pages/knowledge_list_page.dart';
import '../../features/settings/pages/settings_page.dart';
import '../../features/baby/pages/baby_list_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNav(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomePage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/records', builder: (_, __) => const RecordListPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/statistics',
              builder: (_, __) => const StatisticsPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/knowledge',
              builder: (_, __) => const KnowledgeListPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            builder: (_, __) => const SettingsPage(),
            routes: [
              GoRoute(
                  path: 'babies', builder: (_, __) => const BabyListPage()),
            ],
          ),
        ]),
      ],
    ),
  ],
);

class ScaffoldWithNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: s.navHome),
          NavigationDestination(
              icon: const Icon(Icons.edit_note_outlined),
              selectedIcon: const Icon(Icons.edit_note),
              label: s.navRecords),
          NavigationDestination(
              icon: const Icon(Icons.bar_chart_outlined),
              selectedIcon: const Icon(Icons.bar_chart),
              label: s.navStatistics),
          NavigationDestination(
              icon: const Icon(Icons.menu_book_outlined),
              selectedIcon: const Icon(Icons.menu_book),
              label: s.navKnowledge),
          NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: s.navSettings),
        ],
      ),
    );
  }
}
