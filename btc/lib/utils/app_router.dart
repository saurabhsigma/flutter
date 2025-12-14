import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../admin/admin_home.dart';
import '../admin/create_test_screen.dart';
import '../admin/upload_material_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/home_screen.dart';
import '../screens/materials/material_list_screen.dart';
import '../screens/test_series/test_attempt_screen.dart';
import '../screens/test_series/test_detail_screen.dart';
import '../screens/test_series/test_list_screen.dart';
import '../screens/test_series/test_result_screen.dart';
import '../screens/test_series/test_review_screen.dart';
import '../screens/videos/video_list_screen.dart';
import '../widgets/scaffold_with_navbar.dart';

// Private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _dashboardNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final _adminNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'admin');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // StatefulShellRoute for Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'tests', // /home/tests
                    builder: (context, state) => const TestListScreen(),
                    routes: [
                      GoRoute(
                        path: ':id', // /home/tests/:id
                        builder: (context, state) {
                           final id = state.pathParameters['id']!;
                           return TestDetailScreen(testId: id);
                        },
                         routes: [
                           GoRoute(
                            path: 'attempt',
                            builder: (context, state) {
                              final id = state.pathParameters['id']!;
                              return TestAttemptScreen(testId: id);
                            },
                          ),
                          GoRoute(
                            path: 'review',
                            builder: (context, state) {
                              final id = state.pathParameters['id']!;
                              return TestReviewScreen(testId: id);
                            },
                          ),
                        ]
                      ),
                      // We can put result screen here or as a sibling to attempt
                      GoRoute(
                        path: 'result',
                        builder: (context, state) {
                           final extras = state.extra as Map<String, dynamic>?;
                           return TestResultScreen(
                             testId: extras?['testId'] ?? '',
                             score: extras?['score'] ?? 0,
                             totalQuestions: extras?['totalQuestions'] ?? 0,
                             answers: extras?['answers'] ?? {},
                           );
                        },
                      ),

                    ],
                  ),
                  GoRoute(
                    path: 'videos',
                    builder: (context, state) => const VideoListScreen(),
                  ),
                  GoRoute(
                    path: 'materials',
                    builder: (context, state) => const MaterialListScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Dashboard Branch
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                name: 'dashboard',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen(),
                ),
              ),
            ],
          ),

          // Admin Branch
          StatefulShellBranch(
            navigatorKey: _adminNavigatorKey,
            routes: [
              GoRoute(
                path: '/admin',
                name: 'admin',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: AdminHomeScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'create-test',
                    builder: (context, state) => const CreateTestScreen(),
                  ),
                  GoRoute(
                    path: 'upload-material',
                    builder: (context, state) => const UploadMaterialScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
